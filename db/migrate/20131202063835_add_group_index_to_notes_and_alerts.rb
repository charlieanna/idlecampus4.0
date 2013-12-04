class AddGroupIndexToNotesAndAlerts < ActiveRecord::Migration
  def change
    add_index :notes, :group_id
  end
end
