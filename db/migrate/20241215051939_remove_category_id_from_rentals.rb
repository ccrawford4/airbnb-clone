class RemoveCategoryIdFromRentals < ActiveRecord::Migration[8.0]
  def change
    remove_column :rentals, :category_id, :uuid
  end
end
