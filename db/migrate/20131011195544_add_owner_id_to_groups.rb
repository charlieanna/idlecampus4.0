class AddOwnerIdToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :owner_id, :integer
    add_index :groups,:owner_id
  end
end
