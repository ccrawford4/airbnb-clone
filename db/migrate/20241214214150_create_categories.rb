class CreateCategories < ActiveRecord::Migration[8.0]
  def change
    create_table :categories, id: false do |t|
      t.uuid :id, primary_key: true, default: 'gen_random_uuid()'
      t.string :imageUrl
      t.string :name

      t.timestamps
    end
  end
end
