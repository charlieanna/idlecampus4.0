class AddIndexToTimetableEntries < ActiveRecord::Migration
  def change
  	add_index :timetable_entries, :timetable_id
  end
end
