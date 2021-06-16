class Book < ApplicationRecord
  belongs_to :admin_user

  validates_presence_of :name , :price
  validates :price, :numericality => { :greater_than_or_equal_to => 0 }
end
