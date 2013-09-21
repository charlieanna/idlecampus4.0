class AddDeviceIdentifierToUsers < ActiveRecord::Migration
  def change
    add_column :users, :device_identifier, :string
  end
end
