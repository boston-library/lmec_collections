class CreateUserRoles < ActiveRecord::Migration[7.2]
  def change
    create_table :roles do |t|
      t.string :name, null: false
      t.timestamps
    end

    create_table :roles_users, id: false do |t|
      t.references :role, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
    end

    add_index :roles_users, [:role_id, :user_id]
    add_index :roles_users, [:user_id, :role_id]
  end
end
