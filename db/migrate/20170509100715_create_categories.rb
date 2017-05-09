class CreateCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :categories do |t|
      t.string :title
      t.text :description
      t.integer :color, default: 0

      t.integer :user_id, null: false, index: true
      t.string :type

      t.timestamps
    end
  end
end
