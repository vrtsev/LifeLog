class CreateVotes < ActiveRecord::Migration[5.0]
  def change
    create_table :votes do |t|
      t.integer :user_id, null: false, index: true
      t.integer :comment_id, null: false, index: true
    end
  end
end
