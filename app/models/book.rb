class Book < ApplicationRecord
  belongs_to :user
  validates :name, :isbn, :author, presence: true
end
