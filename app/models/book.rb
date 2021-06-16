class Book < ApplicationRecord
  belongs_to :admin_user

  validates :name, :price, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
end
