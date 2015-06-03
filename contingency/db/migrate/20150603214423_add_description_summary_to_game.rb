class AddDescriptionSummaryToGame < ActiveRecord::Migration
  def change
    add_column :games, :description, :text
    add_column :games, :summary, :text
  end
end
