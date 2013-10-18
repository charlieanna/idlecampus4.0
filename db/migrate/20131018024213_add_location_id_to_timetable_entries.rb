class AddLocationIdToTimetableEntries < ActiveRecord::Migration
  def change
    add_column :timetable_entries, :location_id, :integer
  end
end
