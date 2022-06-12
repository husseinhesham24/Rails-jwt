class User < ApplicationRecord
  before_save {self.email = email.downcase}

  has_many :jwt_tokens, dependent: :destroy

  validates :username, presence: true
  validates :email, presence: true, uniqueness: {case_sensitive: false}
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, confirmation: true, presence: true ,length: {minimum: 6, maximum: 20}

  has_secure_password
end
