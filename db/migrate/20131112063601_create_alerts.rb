class CreateAlerts < ActiveRecord::Migration
  def change
    create_table :alerts do |t|
      t.string :message
      t.references :group, index: true

      t.timestamps
    end
  end
end
