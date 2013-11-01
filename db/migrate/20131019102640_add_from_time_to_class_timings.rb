class AddFromTimeToClassTimings < ActiveRecord::Migration
  def change
    add_column :class_timings, :from, :time
    add_column :class_timings, :to, :time
  end
end
