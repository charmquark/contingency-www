class CreateGameMemberships < ActiveRecord::Migration
  def change
    create_table :game_memberships do |t|
      t.references :game, index: true, foreign_key: true
      t.references :member, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
