class CreateTimetableFieldValues < ActiveRecord::Migration
  def change
    create_table :timetable_field_values do |t|
      t.string :name
      t.integer :timetable_field_id

      t.timestamps
    end
  end
end
