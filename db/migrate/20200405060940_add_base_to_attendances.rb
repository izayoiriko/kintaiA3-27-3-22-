class AddBaseToAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :base, :string, default: 1
  end
end
