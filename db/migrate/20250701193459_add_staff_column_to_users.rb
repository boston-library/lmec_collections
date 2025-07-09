class AddStaffColumnToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :staff, :boolean, null: false, default: false
  end
end
