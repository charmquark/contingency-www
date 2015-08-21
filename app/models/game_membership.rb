class GameMembership < ActiveRecord::Base
    belongs_to :game
    belongs_to :member
    
    validates :game,
        presence: true
    
    validates :member,
        presence: true
    
    
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
