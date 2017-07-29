class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.boolean :supplemented, default: false
      t.datetime :supplemented_at
      t.boolean :pinned, default: false
      t.boolean :visible, default: true
      t.boolean :commentable, default: true

      t.integer :user_id, null: false, index: true
      t.integer :category_id, index: true
      t.string :type

      t.timestamps
    end
  end
end
