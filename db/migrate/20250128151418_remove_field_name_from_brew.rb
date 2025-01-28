class RemoveFieldNameFromBrew < ActiveRecord::Migration[7.0]
  def change
    remove_column :brews, :ratingtaste, :string
  end
end
