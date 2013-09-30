class CreateSmallGroups < ActiveRecord::Migration
  def change
    create_table :small_groups do |t|
      t.string :name
      t.integer :group_id

      t.timestamps
    end
  end
end
