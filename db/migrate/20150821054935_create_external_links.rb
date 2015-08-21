class CreateExternalLinks < ActiveRecord::Migration
  def change
    create_table :external_links do |t|
      t.references :member, index: true, foreign_key: true
      t.string :type
      t.string :fragment

      t.timestamps null: false
    end
  end
end
