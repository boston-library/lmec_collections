class FixUserUniqueIndex < ActiveRecord::Migration[7.2]
  def change
    remove_index :users, :email if index_exists?(:users, :email)

    add_index :users, [:provider, :uid], unique: true
    add_index :users, :email
  end
end
