class RemoveUnnecceassycolumnsFromClassTimings < ActiveRecord::Migration
  def change
    remove_column :class_timings,:from_hours
    remove_column :class_timings,:from_minutes
    remove_column :class_timings,:to_hours
    remove_column :class_timings,:to_minutes
  end
end
