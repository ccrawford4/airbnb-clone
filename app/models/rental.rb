class Rental < ApplicationRecord
  has_and_belongs_to_many :categories, dependent: :destroy
  has_many :rental_images, inverse_of: :rental, dependent: :destroy

  validates :short_description, presence: true
  validates :address, presence: true
  validates :price, presence: true

  accepts_nested_attributes_for :rental_images, allow_destroy: true
end
