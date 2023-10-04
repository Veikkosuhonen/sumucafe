class AddLocationIdToRestaurant < ActiveRecord::Migration[7.0]
  def change
    add_column :restaurants, :location_id, :integer
  end
end
