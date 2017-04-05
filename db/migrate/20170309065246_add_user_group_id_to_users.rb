class AddUserGroupIdToUsers < ActiveRecord::Migration[5.0]
  def change
    change_table :users do |t|
      t.belongs_to :user_group, index: true
    end
  end
end
