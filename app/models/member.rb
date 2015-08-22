class Member < ActiveRecord::Base
    scope :core, -> { where(rank: :core) }
    
    scope :not_core, -> { where.not(rank: :core) }
    
    scope :random, -> { order 'random()' }
    
    scope :without_game, ->(g) { all.reject {|r| r.games.include? g } }

    
    has_secure_password
    
    
    has_many :background_images,
        as: :backgroundable
    
    has_many :external_links,
        dependent: :destroy

    has_many :game_memberships,
        {dependent: :destroy},
        -> { includes :game }
    
    has_many :games,
        through: :game_memberships

    has_many :news_post
    
    has_many :videos
    
    
    has_attached_file :avatar,
        default_url: '/images/generic-member-avatar.jpg'
    
    
    validates :avatar,
        attachment_content_type: { content_type: 'image/jpeg' }
    
    validates :handle,
        presence: true,
        uniqueness: true
    
    validates :rank,
        presence: true
    
    validates :role,
        presence: true
    
    
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
        CGI.escape handle
    end
    
    
    def twitch_fragment
        el = ExternalLink.find_by member: self, site: :twitch
        el.nil? ? nil : el.fragment
    end
    
    
    def self.cache_key_for_all
        count = Member.count
        max_updated_at = Member.maximum(:updated_at).try(:utc).try(:to_s, :number)
        "members/all-#{count}-#{max_updated_at}"
    end
    
    
    def self.for_home
        members = Member.core
        m = 11 - members.length
        members += Member.not_core.random.limit(m) if m > 0
        Member.to_sorted members
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
    
    def self.to_sorted(members)
        members.sort do |a, b|
            a.handle.downcase <=> b.handle.downcase
        end
    end
end
