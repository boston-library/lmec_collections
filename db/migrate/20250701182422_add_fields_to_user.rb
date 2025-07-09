class AddFieldsToUser < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :username,     :string
    add_column :users, :provider,     :string
    add_column :users, :display_name, :string
    add_column :users, :first_name,   :string
    add_column :users, :last_name,    :string
    add_column :users, :uid,          :string

    add_index :users, [:uid, :provider]
  end
end
