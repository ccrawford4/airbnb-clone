class Rental < ApplicationRecord
  has_and_belongs_to_many :categories
  has_many :rental_images, primary_key: :id, foreign_key: :rental_id, dependent: :destroy

  validates :address, presence: true
  validates :price, presence: true
end
