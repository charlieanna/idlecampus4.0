class AddIdsToFields < ActiveRecord::Migration
  def change
  	add_column :teachers,:group_id,:integer
  	add_column :subjects,:group_id,:integer
  	add_column :rooms,:group_id,:integer
   add_index :teachers,:group_id
  add_index :subjects,:group_id
  add_index :rooms,:group_id
  end
 
end
