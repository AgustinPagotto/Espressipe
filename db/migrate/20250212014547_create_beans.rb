class CreateBeans < ActiveRecord::Migration[7.0]
  def change
    create_table :beans do |t|
      t.string :name
      t.string :origin
      t.string :process
      t.string :roastlevel
      t.integer :rating
      t.boolean :decaf

      t.timestamps
    end
  end
end
