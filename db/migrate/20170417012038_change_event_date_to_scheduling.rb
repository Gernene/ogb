class ChangeEventDateToScheduling < ActiveRecord::Migration[5.0]
  def change
    rename_column :posts, :event_date, :scheduling
  end
end