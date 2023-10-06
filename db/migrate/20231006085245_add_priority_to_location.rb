class AddPriorityToLocation < ActiveRecord::Migration[7.0]
  def change
    add_column :locations, :priority, :integer, default: 0

    Location.update_all priority: 0
  end
end
