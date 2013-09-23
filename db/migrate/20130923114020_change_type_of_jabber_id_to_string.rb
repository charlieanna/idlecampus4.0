class ChangeTypeOfJabberIdToString < ActiveRecord::Migration
  def change
    change_column :users, :jabber_id,:string
  end
end
