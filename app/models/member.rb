class Member < ActiveRecord::Base
    scope :core, -> { where(rank: :core) }
    
    scope :not_core, -> { where.not(rank: :core) }
    
    scope :random, -> { order 'random()' }
    
    scope :without_game, ->(g) { all - g.members }
    
    
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

    has_many :news_posts
    
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
    
    
    def <=>(other_member)
        handle.downcase <=> other_member.handle.downcase
    end


    def name
        handle
    end
    
    
    def is_admin?
        role == 'admin'
    end
    
    
    def to_param
        CGI.escape handle
    end
    
    
    def twitch_fragment
        el = ExternalLink.find_by member: self, site: :twitch
        el.nil? ? nil : el.fragment
    end
end
