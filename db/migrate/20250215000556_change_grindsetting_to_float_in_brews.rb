class ChangeGrindsettingToFloatInBrews < ActiveRecord::Migration[7.0]
  def change
    change_column :brews, :grindsetting, :float
  end
end
