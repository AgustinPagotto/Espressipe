class ChangeColumnsToFloatInBrews < ActiveRecord::Migration[7.0]
  def change
    change_column :brews, :cofamount, :float
    change_column :brews, :watamount, :float
    change_column :brews, :brewresult, :float
  end
end