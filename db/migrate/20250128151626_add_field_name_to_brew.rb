class AddFieldNameToBrew < ActiveRecord::Migration[7.0]
  def change
    add_column :brews, :brewresult, :integer
  end
end
