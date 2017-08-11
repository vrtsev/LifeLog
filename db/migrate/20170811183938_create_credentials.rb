class CreateCredentials < ActiveRecord::Migration[5.0]
  def change
    create_table :credentials do |t|
      t.string  :provider, null: false
      t.string  :uid, null: false
      t.integer :user_id, null: false, index: true
      t.timestamps
    end
  end
end
