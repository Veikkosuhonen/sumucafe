class AddHiddenToIngredient < ActiveRecord::Migration[7.0]
  def change
    add_column :ingredients, :hidden, :boolean, null: false, default: false
  end
end
