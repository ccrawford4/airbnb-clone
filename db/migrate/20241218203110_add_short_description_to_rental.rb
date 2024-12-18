class AddShortDescriptionToRental < ActiveRecord::Migration[8.0]
  def change
    rename_column :rentals, :description, :short_description
    change_column :rentals, :short_description, :string, limit: 100

    add_column :rentals, :long_description, :text
  end
end
