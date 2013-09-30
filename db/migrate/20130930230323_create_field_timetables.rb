class CreateFieldTimetables < ActiveRecord::Migration
  def change
    create_table :fields_timetables do |t|
      t.integer :field_id
      t.integer :timetable_id

      t.timestamps
    end
  end
end
