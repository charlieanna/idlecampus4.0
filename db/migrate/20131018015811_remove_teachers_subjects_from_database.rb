class RemoveTeachersSubjectsFromDatabase < ActiveRecord::Migration
  def change
  	drop_table :teacherss
  end
end
