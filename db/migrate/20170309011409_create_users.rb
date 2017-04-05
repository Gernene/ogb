class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string  :name
      t.string  :email
      t.string  :account_type
      t.string  :password
      t.string  :password_digest
      t.string  :phone
      t.string  :website
      t.string  :remember_digest
      t.string  :user_group
      t.timestamps
      t.index ["email"], name: "index_users_on_email", unique: true
    end
  end
end
