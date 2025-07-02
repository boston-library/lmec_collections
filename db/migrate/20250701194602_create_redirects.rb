class CreateRedirects < ActiveRecord::Migration[7.2]
  def change
    create_table :redirects do |t|
      t.string :drupal_id
      t.string :repository_id

      t.timestamps
    end
  end
end
