class AddIndexOnGroupId < ActiveRecord::Migration
  def change
  	add_index :timetables,:group_id
  end
end
