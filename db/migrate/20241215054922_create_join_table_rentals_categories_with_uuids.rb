class CreateJoinTableRentalsCategoriesWithUuids < ActiveRecord::Migration[8.0]
  def change
    create_table :categories_rentals, id: :uuid do |t|
      t.uuid :rental_id, null: false
      t.uuid :category_id, null: false
    end

    add_index :categories_rentals, :rental_id
    add_index :categories_rentals, :category_id
    add_foreign_key :categories_rentals, :rentals, column: :rental_id, primary_key: :id
    add_foreign_key :categories_rentals, :categories, column: :category_id, primary_key: :id
  end
end
