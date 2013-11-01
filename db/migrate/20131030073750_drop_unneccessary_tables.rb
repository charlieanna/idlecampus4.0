class DropUnneccessaryTables < ActiveRecord::Migration
  def change
   
    drop_table :fields_timetables
    drop_table :fields
  end
end
