class CreateFeedbacks < ActiveRecord::Migration[5.0]
  def change
    create_table :feedbacks do |t|
      t.string :email
      t.string :subject
      t.text :message
      t.boolean :readed, default: false
      t.timestamps
    end
  end
end
