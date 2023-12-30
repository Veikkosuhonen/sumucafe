class AddRemovedAtToMealIngredient < ActiveRecord::Migration[7.0]
  def change
    add_column :meal_ingredients, :removed_at, :datetime, default: nil, null: true
  end
end
