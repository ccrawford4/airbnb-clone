class CreateRentalImages < ActiveRecord::Migration[8.0]
  def change
    create_table :rental_images, id: :uuid do |t|
      t.string :image_url, null: false
      t.uuid :rental_id, null: false
      t.string :description

      t.timestamps
    end
  end
end
