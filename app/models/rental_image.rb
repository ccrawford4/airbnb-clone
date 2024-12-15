class RentalImage < ApplicationRecord
  belongs_to :rental, primary_key: :id, foreign_key: :rental_id

  validates :image_url, presence: true
  validates :rental_id, presence: true
end
