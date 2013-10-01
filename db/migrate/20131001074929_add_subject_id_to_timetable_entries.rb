class AddSubjectIdToTimetableEntries < ActiveRecord::Migration
  def change
    add_column :timetable_entries, :subject_id, :integer
  end
end
