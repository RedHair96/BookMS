class Book < ApplicationRecord
  validates :name, :isbn, :author, presence: true
end
