class User < ApplicationRecord
  ITERATIONS = 20000
  DIGEST = OpenSSL::Digest::SHA256.new
  EMAIL_VAL_REGEXP = URI::MailTo::EMAIL_REGEXP
  BACKGROUND_COLOR_REGEX = /\A#([\da-f]{3}){1,2}\z/
  USERNAME_REGEX = /\A\w{1,40}\z/
  DEFAULT_BACKGROUND_COLOR = '#5F9EA0'
  
  attr_accessor :password

  before_validation :downcase_username_email

  validates :username, format: { with: USERNAME_REGEX }

  validates :email, format: { with: EMAIL_VAL_REGEXP }

  validates :email, :username, 
            presence: true,
            uniqueness: true

  validates :password, presence: true, on: :create
  validates :password, confirmation: true
  validates :bg_color, format: {with: BACKGROUND_COLOR_REGEX}, on: :update

  before_save :encrypt_password

  has_many :questions

  def self.hash_to_string(password_hash)
    password_hash.unpack('H*')[0]
  end

  def self.authenticate(email, password)
    user = find_by(email: email)

    if user.present? && user.password_hash == User.hash_to_string(
      OpenSSL::PKCS5.pbkdf2_hmac(password, user.password_salt, ITERATIONS, DIGEST.length, DIGEST)
    )
      user
    end
  end

  def background_color
    bg_color || DEFAULT_BACKGROUND_COLOR
  end

  private

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

  def downcase_username_email
    username&.downcase!
    email&.downcase!
  end
end
