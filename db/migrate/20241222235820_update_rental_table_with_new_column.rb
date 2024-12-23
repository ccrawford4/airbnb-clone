class UpdateRentalTableWithNewColumn < ActiveRecord::Migration[8.0]
  def change
    add_column :rentals, :latitude, :decimal, precision: 10, scale: 6
    add_column :rentals, :longitude, :decimal, precision: 10, scale: 6
    change_column :rentals, :price, :decimal, precision: 2, scale: 0
  end
end
