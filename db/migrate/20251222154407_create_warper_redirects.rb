class CreateWarperRedirects < ActiveRecord::Migration[7.2]
  def change
    create_table :warper_redirects do |t|
      t.integer :warper_id
      t.string :repository_id

      t.timestamps
    end
  end
end
