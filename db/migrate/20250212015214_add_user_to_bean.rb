class AddUserToBean < ActiveRecord::Migration[7.0]
  def change
    add_reference :beans, :user, null: false, foreign_key: true
  end
end
