class AddMessageToNotes < ActiveRecord::Migration
  def change
    add_column :notes, :message, :text
  end
end
