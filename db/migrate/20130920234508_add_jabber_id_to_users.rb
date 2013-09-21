class AddJabberIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :jabber_id, :integer
  end
end
