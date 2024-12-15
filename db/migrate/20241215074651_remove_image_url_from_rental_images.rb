class RemoveImageUrlFromRentalImages < ActiveRecord::Migration[8.0]
  def change
    remove_column :rental_images, :image_url, :string
  end
end
