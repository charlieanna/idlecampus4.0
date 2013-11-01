class AdRowIdToTimetableEntry < ActiveRecord::Migration
  def change
   add_column :timetable_entries,:room_id,:integer
  end
end
