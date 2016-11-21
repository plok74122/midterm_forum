class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.integer :request_id
      t.text :details

      t.timestamps
    end
    add_index :comments, :user_id
    add_index :comments, :request_id
  end
end
