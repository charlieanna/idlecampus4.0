class AddUserIndexToGroups < ActiveRecord::Migration
  def change
    add_index :groups,:user_id
  end
end
