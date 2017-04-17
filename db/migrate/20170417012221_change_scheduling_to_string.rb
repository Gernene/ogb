class ChangeSchedulingToString < ActiveRecord::Migration[5.0]
  def change
    change_column :posts, :scheduling, :string
  end
end
