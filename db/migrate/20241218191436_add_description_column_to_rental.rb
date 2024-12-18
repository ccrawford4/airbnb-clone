class AddDescriptionColumnToRental < ActiveRecord::Migration[8.0]
  def change
    add_column :rentals, :description, :string
  end
end
