class RentalImage < ApplicationRecord
  belongs_to :rental, inverse_of: :rental_images, optional: true

   has_one_attached :image

  validates :image, presence: true, if: :new_record?
  validates :description, presence: true, if: :new_record?
end
