class RemoveSlugIdAndOwnerIdFromGroups < ActiveRecord::Migration
  def change
    remove_column :users,:owner_id
  end
end