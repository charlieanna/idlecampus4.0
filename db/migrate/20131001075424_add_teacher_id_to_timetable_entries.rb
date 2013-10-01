class AddTeacherIdToTimetableEntries < ActiveRecord::Migration
  def change
    add_column :timetable_entries, :teacher_id, :integer
  end
end
