class CreateBrews < ActiveRecord::Migration[7.0]
  def change
    create_table :brews do |t|
      t.integer :cofamount
      t.integer :watamount
      t.string :method
      t.integer :grindsetting
      t.integer :temperature
      t.date :date
      t.integer :extractiontime
      t.integer :ratingbrew
      t.integer :ratingtaste

      t.timestamps
    end
  end
end
