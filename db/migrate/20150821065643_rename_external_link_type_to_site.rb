class RenameExternalLinkTypeToSite < ActiveRecord::Migration
    def change
        rename_column :external_links, :type, :site
    end
end
