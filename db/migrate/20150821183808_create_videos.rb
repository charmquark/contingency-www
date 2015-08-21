class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.references :game, index: true, foreign_key: true
      t.references :member, index: true, foreign_key: true
      t.string :fragment

      t.timestamps null: false
    end
  end
end
