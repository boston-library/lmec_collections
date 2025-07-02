class CreatePolarisLookups < ActiveRecord::Migration[7.2]
  def change
    create_table :polaris_lookups do |t|
      t.string :item_id
      t.string :bib_id
      t.string :horizon_id
      t.string :barcode_id
      t.string :archive_id

      t.timestamps
    end

    add_index :polaris_lookups, :item_id, unique: true
    add_index :polaris_lookups, :bib_id, unique: true
    add_index :polaris_lookups, :horizon_id, unique: true
    add_index :polaris_lookups, :barcode_id, unique: true
    add_index :polaris_lookups, :archive_id
  end
end
