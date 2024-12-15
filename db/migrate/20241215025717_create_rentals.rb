class CreateRentals < ActiveRecord::Migration[8.0]
  def change
    create_table :rentals, id: :uuid do |t|
      t.uuid :category_id, null: false
      t.string :address, null: false
      t.decimal :score
      t.decimal :price, null: false

      t.timestamps
    end

    add_foreign_key :rentals, :categories, column: :category_id, primary_key: :id
  end
end
