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
end
