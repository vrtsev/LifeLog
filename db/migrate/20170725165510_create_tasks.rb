class CreateTasks < ActiveRecord::Migration[5.0]
  def change
    create_table :tasks do |t|
      t.string :title
      t.integer :status, default: 0
      t.integer :user_id, null: false, index: true
      t.integer :goal_id, null: false, index: true
      t.integer :parent_id

      t.timestamps
    end
  end
end
