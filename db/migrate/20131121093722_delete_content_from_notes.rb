class DeleteContentFromNotes < ActiveRecord::Migration
  def change
    remove_column :users,:content
  end
end
