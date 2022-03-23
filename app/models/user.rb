class User < ApplicationRecord
  #Параметры работы модулй шифрвания
  ITERATIONS = 20000
  DIGEST = OpenSSL::Digest::SHA256.new

  attr_accessor :password

  before_validation :downcase_username

  validates :username, format: { with: /\A[a-zA-Z0-9_]{1,40}\z/ }

  validates :email, format: {with: URI::MailTo::EMAIL_REGEXP}

  validates :email, :username, 
            presence: true,
            uniqueness: true

  validates :password, presence: true, on: :create
  validates :password, confirmation: true

  before_save :encrypt_password

  has_many :questions

  def self.hash_to_string(password_hash)
    password_hash.unpack('H*')[0]
  end

  def encrypt_password
    if self.password.present?
      #создаем "соль" — рандомная строка усложняющая задачу хацкерам
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
    end
  end

  def downcase_username
    self.username.downcase!
  end
end
