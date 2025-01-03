class CreateRentalTypes < ActiveRecord::Migration[8.0]
  def change
    create_table :rental_types, id: :uuid do |t|
      t.string :name, null: false
      t.string :image_url, null: false
      t.timestamps
    end
  end
end
