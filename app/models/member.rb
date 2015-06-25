class Member < ActiveRecord::Base
    AVATAR_SIZES = {
        normal: '125x125',
        small:  '75x75'
    }
    
    
    has_attached_file :avatar
    
    validates :avatar,
        attachment_presence: true,
        attachment_content_type: { content_type: 'image/jpeg' }

    has_many :news_post

    has_secure_password
    
    
    def rank_obj
        ContingencyRanks.from_sym rank
    end
    
    
    def to_param
        handle
    end
    
    def self.to_rank_groups(members)
        result = Hash.new {|hash, key| hash[key] = [] }
        members.each do |member|
            result[member.rank.to_sym] << member
        end
        result
    end
    
    def self.to_rank_order(members)
        groups = to_rank_groups members
        result = []
        ContingencyRanks::RANKS.each do |r|
            result.concat groups[r.symbol]
        end
        result
    end
end
