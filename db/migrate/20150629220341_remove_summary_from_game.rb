class RemoveSummaryFromGame < ActiveRecord::Migration
    def change
        remove_column :games, :summary
    end
end
