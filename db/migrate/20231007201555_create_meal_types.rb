class CreateMealTypes < ActiveRecord::Migration[7.0]
  def change
    create_table :meal_types do |t|
      t.string :name
      t.string :color
      t.json :price

      t.timestamps
    end

    add_column :meals, :meal_type_id, :integer
  end
end
