class AddGroupsIdToNotes < ActiveRecord::Migration
  def change
    add_column :notes, :group_id, :integer
  end
end
