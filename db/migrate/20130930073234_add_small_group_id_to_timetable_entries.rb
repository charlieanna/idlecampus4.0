class AddSmallGroupIdToTimetableEntries < ActiveRecord::Migration
  def change
    add_column :timetable_entries, :small_group_id, :integer
  end
end
