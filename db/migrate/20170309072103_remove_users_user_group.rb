class RemoveUsersUserGroup < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :user_group
  end
end
