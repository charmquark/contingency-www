class Member < ActiveRecord::Base
    scope :core, -> { where(rank: :core) }
    
    scope :not_core, -> { where.not(rank: :core) }
    
    scope :random, -> { order 'random()' }
    
    has_attached_file :avatar,
        default_url: ''
    
    validates :avatar,
        attachment_presence: true,
        attachment_content_type: { content_type: 'image/jpeg' }
    
    validates :handle,
        presence: true,
        uniqueness: true
    
    validates :rank,
        presence: true
    
    validates :role,
        presence: true

    has_many :news_post

    has_secure_password
    
    
    def is_admin?
        role == 'admin'
    end
    
    
    def rank_obj
        ContingencyRanks.from_sym rank
    end
    
    
    def role_obj
        ContingencyRoles.from_sym role
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
