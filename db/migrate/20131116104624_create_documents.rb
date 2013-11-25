class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.references :folder, index: true

      t.timestamps
    end
  end
end
