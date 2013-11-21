class AddDefaultValueToUsersDeviceIdentifier < ActiveRecord::Migration
  def change
    change_column :users, :device_identifier, :string, :default => "web"
  end
end
