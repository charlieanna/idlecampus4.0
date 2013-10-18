class AddTimetableIdToTimetableFields < ActiveRecord::Migration
  def change
    add_column :timetable_fields, :timetable_id, :integer
  end
end
