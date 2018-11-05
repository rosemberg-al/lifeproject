class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :full_name
      t.string :email
      t.string :password_digest
      t.text :bio
      t.datetime :confirmed_at
      t.string :confirmation_token

      t.timestamps
    end
      
    add_index :users, :email, :unique => true
  end
end
