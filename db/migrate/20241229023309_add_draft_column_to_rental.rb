class AddDraftColumnToRental < ActiveRecord::Migration[8.0]
  def change
    add_column :rentals, :draft, :boolean, default: false
  end
end
