class Game < ActiveRecord::Base
    DEFAULT_BANNER_URL = '/images/generic-game-banner.jpg'
    
    scope :featured, -> { where featured: true }
    
    scope :not_featured, -> { where featured: false }
    
    scope :random, -> { order 'random()' }
    
    scope :without_member, ->(m) { all - m.games }
    

    has_many :background_images,
        as: :backgroundable
    
    has_many :game_memberships,
        {dependent: :destroy},
        -> { includes :member }
    
    has_many :members,
        through: :game_memberships
    
    has_many :news_posts
    
    has_many :videos
    
    
    has_attached_file :banner,
        default_url: DEFAULT_BANNER_URL
    
    
    validates :banner,
        attachment_content_type: { content_type: 'image/jpeg' }
    
    validates :name,
        presence: true,
        uniqueness: true
    
    validates :slug,
        presence: true,
        uniqueness: true
    
    
    def <=>(other_game)
        name.downcase <=> other_game.name.downcase
    end
    
    
    def to_param
        CGI.escape slug
    end
end
