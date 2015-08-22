class Video < ActiveRecord::Base
    scope :recent, -> { order(id: 'desc').limit(6) }
    
    
    belongs_to :game
    belongs_to :member
    
    
    validates :fragment,
        presence: true
    
    validates :member,
        presence: true


    def self.cache_key_for_game(game)
        count = Video.where(game: game).count
        max_updated_at = Video.maximum(:updated_at).try(:utc).try(:to_s, :number)
        "videos/game-#{game.id}/#{count}-#{max_updated_at}"
    end
    
    def self.cache_key_for_member(member)
        count = Video.where(member: member).count
        max_updated_at = Video.maximum(:updated_at).try(:utc).try(:to_s, :number)
        "videos/member-#{member.id}/#{count}-#{max_updated_at}"
    end
end
