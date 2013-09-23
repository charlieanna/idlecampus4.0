class CreateClassTimings < ActiveRecord::Migration
  def change
    create_table :class_timings do |t|
      t.integer :to_minutes
      t.integer :to_hours
      t.integer :from_hours
      t.integer :from_minutes

      t.timestamps
    end
  end
end
