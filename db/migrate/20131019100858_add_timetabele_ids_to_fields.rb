class AddTimetabeleIdsToFields < ActiveRecord::Migration
  def change
  	add_column :teachers,:timetable_id,:integer
  	add_column :subjects,:timetable_id,:integer
  	add_column :rooms,:timetable_id,:integer
   add_index :teachers,:timetable_id
  add_index :subjects,:timetable_id
  add_index :rooms,:timetable_id
  end
end
