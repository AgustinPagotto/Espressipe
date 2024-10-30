class AddUsrColToBrew < ActiveRecord::Migration[7.0]
  def change
    add_reference :brews, :user, foreign_key: true
  end
end
