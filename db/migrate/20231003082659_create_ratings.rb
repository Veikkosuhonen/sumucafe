class CreateRatings < ActiveRecord::Migration[7.0]
  def change
    create_table :ratings do |t|
      t.integer :meal_id
      t.integer :user_id
      t.integer :rating

      t.timestamps
    end
  end
end
