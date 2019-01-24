class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email, presence: true
      t.string :username, presence: true
      t.string :encrypted_password
      t.string :salt
      t.string :auth_token
      t.string :type, default: 'Member', limit: 20

      t.timestamps
    end
    add_index :users, :email, unique: true
    add_index :users, :auth_token, unique: true
  end
end
