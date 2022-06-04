class User < ApplicationRecord
  before_save {self.email = email.downcase}

  validates :username, presence: true, uniqueness: { case_sensitive: true }
  validates :email, presence: true, uniqueness: {case_sensitive: false}
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, confirmation: true, presence: true ,length: {minimum: 6, maximum: 20}

  has_secure_password
end
