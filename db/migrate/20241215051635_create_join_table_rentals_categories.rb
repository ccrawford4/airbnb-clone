class CreateJoinTableRentalsCategories < ActiveRecord::Migration[8.0]
  def change
    create_join_table :rentals, :categories do |t|
      t.index :rental_id
      t.index :category_id
    end
  end
end
