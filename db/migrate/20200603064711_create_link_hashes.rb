class CreateLinkHashes < ActiveRecord::Migration[5.1]
  def change
    create_table :link_hashes do |t|
      t.string :slug
      t.integer :user_id

      t.timestamps
    end
    add_index :link_hashes, :slug, unique: true
  end
end
