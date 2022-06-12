class JwtToken < ApplicationRecord
  belongs_to :user
  validates :token, presence: true, uniqueness: {case_sensitive: true}
  validates :exp, presence: true
end
