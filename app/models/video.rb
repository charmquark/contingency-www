class Video < ActiveRecord::Base
    MEMBER_QUOTA = 9
    
    
    scope :recent, -> { order(id: 'desc').limit(6) }
    
    
    belongs_to :game
    belongs_to :member
    
    
    validates :fragment,
        presence: true
    
    validates :member,
        presence: true
end
