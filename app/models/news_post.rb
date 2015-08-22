class NewsPost < ActiveRecord::Base
    PERMITTED = [:title, :game_id, :short_body, :long_body]
    
    belongs_to :game
    belongs_to :member
    
    
    validates :title,
        presence: true
    
    validates :member_id,
        presence: true
    
    validates :short_body,
        presence: true
    
    
    def self.cache_key_for_all
        count = NewsPost.count
        max_updated_at = NewsPost.maximum(:updated_at).try(:utc).try(:to_s, :number)
        "news_posts/all-#{count}-#{max_updated_at}"
    end
    
    def self.cache_key_for_game(game)
        count = NewsPost.where(game: game).count
        max_updated_at = NewsPost.maximum(:updated_at).try(:utc).try(:to_s, :number)
        "news_posts/game-#{game.id}/#{count}-#{max_updated_at}"
    end
end
