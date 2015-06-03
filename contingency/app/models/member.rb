class Member < ActiveRecord::Base
    AVATAR_SIZES = {
        normal: '125x125',
        small:  '75x75'
    }
    
    
    has_attached_file :avatar
    
    validates :avatar,
        attachment_presence: true,
        attachment_content_type: { content_type: 'image/jpeg' }


    has_secure_password
    
    
    def rank_obj
        ContingencyRanks.from_sym rank
    end
    
    
    def to_param
        handle
    end
end
