class CreateLocations < ActiveRecord::Migration[8.0]
  def change
    create_table :locations, id: :uuid do |t|
      t.string :address
      t.decimal :latitude
      t.decimal :longitude

      t.timestamps
    end
  end
end
