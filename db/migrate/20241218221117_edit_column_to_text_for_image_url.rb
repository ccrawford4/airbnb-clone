class EditColumnToTextForImageUrl < ActiveRecord::Migration[8.0]
  def change
    change_column :rental_types, :image_url, :text
  end
end
