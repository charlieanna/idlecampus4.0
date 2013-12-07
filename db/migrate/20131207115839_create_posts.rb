class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :article_id
      t.string :article_type

      t.timestamps
    end
    add_index :posts, [:article_id, :article_type]
  end
end
