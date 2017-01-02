class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :body
      t.integer :user_id
      t.boolean :draft, default: false
      t.boolean :published, default: false
      t.integer :views, default: 0

      t.timestamps null: false
    end
  end
end
