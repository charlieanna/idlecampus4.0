class AddWeekdayIdToTimetableEntry < ActiveRecord::Migration
  def change
    add_column :timetable_entries, :weekday_id, :integer
  end
end
