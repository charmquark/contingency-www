class NewsPost < ActiveRecord::Base
    scope :recent, -> { order(created_at: :desc).limit(8) }
    
    
    belongs_to :game
    belongs_to :member
    
    
    validates :title,
        presence: true
    
    validates :member_id,
        presence: true
    
    validates :short_body,
        presence: true
    
    
    def related
        posts = NewsPost.recent.where(game: self.game).where.not(id: self.id).limit(3)
        more = 3 - posts.length
        if more > 0 then
            posts += NewsPost.recent.where.not(id: self.id, game: self.game).limit(more)
        end
        posts
    end
end
