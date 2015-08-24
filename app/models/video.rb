class Video < ActiveRecord::Base
    scope :recent, -> { order(id: 'desc').limit(6) }
    
    
    belongs_to :game
    belongs_to :member
    
    
    validates :fragment,
        presence: true
    
    validates :member,
        presence: true
end
