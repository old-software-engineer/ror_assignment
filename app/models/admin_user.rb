class AdminUser < ApplicationRecord
  devise :database_authenticatable, :registerable, :rememberable, :validatable,
         :trackable, :recoverable

  validates :email, presence: true

  has_many :books
end
