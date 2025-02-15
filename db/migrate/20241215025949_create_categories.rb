class CreateCategories < ActiveRecord::Migration[8.0]
  def change
    create_table :categories, id: :uuid do |t|
      t.string :image_url, null: false
      t.string :name, null: false

      t.timestamps
    end
  end
end
