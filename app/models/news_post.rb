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
end
