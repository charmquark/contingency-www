class AddAttachmentLogoToGames < ActiveRecord::Migration
  def self.up
    change_table :games do |t|
      t.attachment :logo
    end
  end

  def self.down
    remove_attachment :games, :logo
  end
end
