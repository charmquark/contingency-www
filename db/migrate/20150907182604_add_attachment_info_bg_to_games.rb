class AddAttachmentInfoBgToGames < ActiveRecord::Migration
  def self.up
    change_table :games do |t|
      t.attachment :info_bg
    end
  end

  def self.down
    remove_attachment :games, :info_bg
  end
end
