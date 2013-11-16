class AddFileToFolders < ActiveRecord::Migration
  def change
    add_column :folders, :file, :string
  end
end
