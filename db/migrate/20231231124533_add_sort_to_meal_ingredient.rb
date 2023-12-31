class AddSortToMealIngredient < ActiveRecord::Migration[7.0]
  def change
    add_column :meal_ingredients, :sort, :integer, null: false, default: 0
  end
end
