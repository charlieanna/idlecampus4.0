class ChangeUsersTable < ActiveRecord::Migration
  def change
    remove_column :users,:type
    remove_column :users,:type_id
    add_column :users,:member_id,:integer
    add_column :users,:member_type,:string
  end
end
