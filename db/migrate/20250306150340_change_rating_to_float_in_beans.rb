class ChangeRatingToFloatInBeans < ActiveRecord::Migration[7.0]
  def up
    change_column :beans, :rating, :float
  end

  def down
    change_column :beans, :rating, :integer
  end
end
