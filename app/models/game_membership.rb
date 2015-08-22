class GameMembership < ActiveRecord::Base
    belongs_to :game
    belongs_to :member
    
    validates :game,
        presence: true
    
    validates :member,
        presence: true


    def self.cache_key_for_assoc(assoc, assoc_type)
        count = assoc.game_memberships.count
        max_updated_at = GameMembership.maximum(:updated_at).try(:utc).try(:to_s, :number)
        "game_memberships/#{assoc_type}-#{assoc.id}/#{count}-#{max_updated_at}"
    end
    
    
    def self.sort_by_game(gms)
        gms.sort do |a, b|
            a.game.name.downcase <=> b.game.name.downcase
        end
    end
    
    def self.sort_by_member(gms)
        gms.sort do |a, b|
            a.member.handle.downcase <=> b.member.handle.downcase
        end
    end
end
