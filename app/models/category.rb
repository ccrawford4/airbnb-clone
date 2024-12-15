class Category < ApplicationRecord
  has_many :rentals, primary_key: :id, foreign_key: :category_id

  validates :image_url, presence: true
  validates :name, presence: true
end
