class DropCategoriesRentalsJoinTable < ActiveRecord::Migration[8.0]
  def change
    drop_table :categories_rentals
  end
end
