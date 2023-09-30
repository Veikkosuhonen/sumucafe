class CreateMenuItems < ActiveRecord::Migration[7.0]
  def change
    create_table :menu_items do |t|
      t.integer :restaurant_id
      t.integer :meal_id
      t.date :menu_date

      t.timestamps
    end
  end
end
