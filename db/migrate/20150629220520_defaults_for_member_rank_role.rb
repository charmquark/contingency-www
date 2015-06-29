class DefaultsForMemberRankRole < ActiveRecord::Migration
    def change
        change_column_default   :members    , :rank , :general
        change_column_default   :members    , :role , :user
    end
end
