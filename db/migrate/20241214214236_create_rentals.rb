class CreateRentals < ActiveRecord::Migration[8.0]
  def change
    create_table :rentals do |t|
      t.uuid :category_id, null: false
      t.string :address
      t.decimal :score
      t.decimal :price

      t.timestamps
    end

    add_foreign_key :rentals, :categories, column: :category_id, primary_key: :id
  end
end
