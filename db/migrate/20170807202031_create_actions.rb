class CreateActions < ActiveRecord::Migration[5.0]
  def change
    create_table :actions do |t|
      t.text :content
      t.integer :kind, default: 0
      t.integer :goal_id, null: false, index: true
      t.timestamps
    end
  end
end
