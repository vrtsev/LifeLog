class CreateGoals < ActiveRecord::Migration[5.0]
  def change
    create_table :goals do |t|
      t.string  :title
      t.text    :description
      t.integer :status, default: 0
      t.integer :progress, default: 0
      t.date    :start_date
      t.date    :end_date
      t.integer :parent_id
      t.integer :category_id
      t.integer :user_id, null: false, index: true
    end
  end
end
