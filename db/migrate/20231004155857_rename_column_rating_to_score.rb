class RenameColumnRatingToScore < ActiveRecord::Migration[7.0]
  def change
    change_table :ratings do |t|
      t.rename :rating, :score
    end
  end
end
