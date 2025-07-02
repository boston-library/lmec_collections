class CreateUserInstitutions < ActiveRecord::Migration[7.2]
  def change
    create_table :institutions do |t|
      t.string :name
      t.string :pid

      t.timestamps
    end

    create_table :institutions_users, id: false do |t|
      t.references :institution, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
    end

    add_index :institutions_users, [:institution_id, :user_id]
    add_index :institutions_users, [:user_id, :institution_id]
  end
end
