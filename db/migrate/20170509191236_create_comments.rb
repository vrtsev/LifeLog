class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.text :content
      t.integer :post_id, null: false, index: true
      t.integer :user_id, null: false, index: true
      t.string :type

      t.timestamps
    end
  end
end
