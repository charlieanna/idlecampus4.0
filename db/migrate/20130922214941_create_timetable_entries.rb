class CreateTimetableEntries < ActiveRecord::Migration
  def change
    create_table :timetable_entries do |t|
      t.integer :timetable_id

      t.timestamps
    end
  end
end
