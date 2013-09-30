class AddClassTimingIdToTimetableEntries < ActiveRecord::Migration
  def change
    add_column :timetable_entries, :class_timing_id, :integer
  end
end
