class GameMembership < ActiveRecord::Base
    belongs_to :game
    belongs_to :member
    
    validates :game,
        presence: true
    
    validates :member,
        presence: true
end
