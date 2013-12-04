class RemoveTeachersAndThenAddTeachers < ActiveRecord::Migration
  def change
    drop_table :teachers
    create_table :teachers, force: true do |t|
      t.string   "name"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "group_id"
      t.integer  "timetable_id"
    end

    add_index :teachers, ["group_id"], name: "index_teachers_on_group_id"
    add_index :teachers, ["timetable_id"], name: "index_teachers_on_timetable_id"
  end
end
