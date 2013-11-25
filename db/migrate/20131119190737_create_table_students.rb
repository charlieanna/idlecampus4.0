class CreateTableStudents < ActiveRecord::Migration
  def change
    create_table :students
    create_table :teachers
    
  end
end
