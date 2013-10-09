class AddTestIndex < ActiveRecord::Migration
  def up
     remove_index :users,:name
  end
end
