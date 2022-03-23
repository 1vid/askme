require'openssl'
require 'uri'

class User < ApplicationRecord
  #Параметры работы модулй шифрвания
  ITERATIONS = 20000
  DIGEST = OpenSSL::Digest::SHA256.new

  has_many :questions

  #Проверка формата электронной почты пользователя
  validates_format_of :email, with: URI::MailTo::EMAIL_REGEXP, on: :create
  #Проверка максимальной длины юзернейма пользователя (не больше 40 символов)
  validates :username, length: {maximum: 40}, allow_blank: true, on: :create
  #Проверка формата юзернейма пользователя (только латинские буквы, цифры, и знак _)
  validates_format_of :email, with: "/^[A-Za-z0-9_]+$/", on: :create
  validates :email, :username, presence: true
  validates :email, :username, uniqueness: true

  attr_accessor :password

  validates_presence_of :password, on: :create
  validates_confirmation_of :password

  before_save :encrypt_password
  
  def self.hash_to_string(password_hash)
    password_hash.unpack('H*')[0]
  end

  def encrypt_password
    if self.password.present?
      #создаем т. н. "соль" — рандомная строка усложняющая задачу хацкерам
      self.password_salt = User.hash_to_string(OpenSSL::Random.random_bytes(16))

      # создаем хэш пароля — длинная уникальная строка, из которой невозможно восстановить
      # исходный пароль
      self.password_hash = User.hash_to_string(
        OpenSSL::PKCS5.pbkdf2_hmac(self.password, self.password_salt, ITERATIONS, DIGEST.length, DIGEST)
      )
    end
  end

  def self.authenticate(email, password)
    user = find_by(email: email)

    if user.present? && user.password_hash == User.hash_to_string(
      OpenSSL::PKCS5.pbkdf2_hmac(password, user.password_salt, ITERATIONS, DIGEST.length, DIGEST)
    )
      user
    else
      nil
    end
  end
end
