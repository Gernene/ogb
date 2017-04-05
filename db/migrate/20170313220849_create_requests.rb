class CreateRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :requests do |t|
      t.belongs_to :user, index: true
      t.belongs_to :post, index: true
      t.text :message
      t.timestamps
    end
  end
end
