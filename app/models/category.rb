class Category < ApplicationRecord
  has_and_belongs_to_many :rentals

  validates :image_url, presence: true
  validates :name, presence: true
end
