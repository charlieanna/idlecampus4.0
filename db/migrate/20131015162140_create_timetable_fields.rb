class CreateTimetableFields < ActiveRecord::Migration
  def change
    create_table :timetable_fields do |t|
      t.string :name
      t.integer :group_id

      t.timestamps
    end
  end
end
