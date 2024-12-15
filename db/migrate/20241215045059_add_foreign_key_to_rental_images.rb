class AddForeignKeyToRentalImages < ActiveRecord::Migration[8.0]
  def change
    remove_foreign_key :rental_images, :rentals if foreign_key_exists?(:rental_images, :rentals)
    add_foreign_key :rental_images, :rentals, column: :rental_id, primary_key: :id, on_delete: :cascade
  end
end
