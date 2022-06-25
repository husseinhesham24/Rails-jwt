class Todo < ApplicationRecord
  belongs_to :user
  belongs_to :category

  validates :todo, length: {minimum:0, maximum: 255}
end
