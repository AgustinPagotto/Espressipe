class RemoveDateFromBrews < ActiveRecord::Migration[7.0]
  def change
    remove_column :brews, :date, :datetime
  end
end
