class User < ApplicationRecord
  before_save {self.email = email.downcase}

  has_many :todos, dependent: :destroy

  validates :username, presence: true
  validates :email, presence: true, uniqueness: {case_sensitive: false}
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, confirmation: true ,length: { maximum: 20 }

  has_secure_password
end
