class Category < ApplicationRecord
  has_many :todos

  validates :name, uniqueness: {case_sensitive: false}, length: {minimum:0, maximum: 255}
end
