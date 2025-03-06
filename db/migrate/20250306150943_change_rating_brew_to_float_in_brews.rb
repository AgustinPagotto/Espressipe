class ChangeRatingBrewToFloatInBrews < ActiveRecord::Migration[7.0]
  def up
    change_column :brews, :ratingbrew, :float
  end

  def down
    change_column :brews, :ratingbrew, :integer
  end
end
