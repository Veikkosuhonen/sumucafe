class AddIsCanceledToMenuItem < ActiveRecord::Migration[7.0]
  def change
    add_column :menu_items, :is_canceled, :boolean, default: false
  end
end
