class AddBeanToBrews < ActiveRecord::Migration[7.0]
  def change
    add_reference :brews, :bean, null: false, foreign_key: true
  end
end
