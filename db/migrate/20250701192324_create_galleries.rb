class CreateGalleries < ActiveRecord::Migration[7.2]
  def change
    create_table :galleries do |t|
      t.string :name, null: false
      t.references :user, null: false, index: true, foreign_key: { on_delete: :cascade }
      t.string :repo_objects, array: true, default: [], null: false
      t.integer :map_sets, array: true, default: [], null: false

      t.timestamps
    end
  end
end
