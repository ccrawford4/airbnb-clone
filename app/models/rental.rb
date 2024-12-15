class Rental < ApplicationRecord
  belongs_to :category, primary_key: :id, foreign_key: :category_id
  has_many :rental_images, primary_key: :id, foreign_key: :rental_id

  validates :category_id, presence: true
  validates :address, presence: true
  validates :price, presence: true
end
