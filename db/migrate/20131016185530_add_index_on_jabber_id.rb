class AddIndexOnJabberId < ActiveRecord::Migration
  def change
  	add_index :users,:jabber_id
  end
end
