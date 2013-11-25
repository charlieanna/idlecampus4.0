class DeleteContentFromNotes < ActiveRecord::Migration
  def change
    remove_column :notes,:content
  end
end
