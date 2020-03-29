class AddBaseToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :base, :integer, default: 1
  end
end
