class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.integer :request_id
      t.text :details

      t.timestamps
    end
    add_index :users, :user_id
    add_index :requests, :request_id
  end
end
