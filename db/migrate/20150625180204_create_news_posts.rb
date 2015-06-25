class CreateNewsPosts < ActiveRecord::Migration
  def change
    create_table :news_posts do |t|
      t.string :title
      t.references :member, index: true, foreign_key: true
      t.references :game, index: true, foreign_key: true
      t.text :short_body
      t.text :long_body

      t.timestamps null: false
    end
  end
end
