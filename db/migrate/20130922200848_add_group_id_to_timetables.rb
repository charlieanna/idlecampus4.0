class AddGroupIdToTimetables < ActiveRecord::Migration
  def change
    add_column :timetables, :group_id, :integer
  end
end
