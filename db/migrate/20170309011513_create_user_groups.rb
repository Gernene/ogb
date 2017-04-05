class CreateUserGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :user_groups do |t|
      t.string   :name
      t.boolean :edit_users
      t.boolean :edit_posts
      t.boolean :log_in
      t.index ["name"], name: "index_user_groups_on_name", unique: true
      t.timestamps
    end
  end
end
