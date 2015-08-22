class Game < ActiveRecord::Base
    DEFAULT_BANNER_URL = '/images/generic-game-banner.jpg'
    
    scope :featured, -> { where featured: true }
    
    scope :not_featured, -> { where featured: false }
    
    scope :random, -> { order 'random()' }
    
    scope :without_member, ->(m) { all.reject {|r| r.members.include? m } }
    

    has_many :background_images,
        as: :backgroundable
    
    has_many :game_memberships,
        {dependent: :destroy},
        -> { includes :member }
    
    has_many :news_post
    
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

    
    def to_param
        CGI.escape slug
    end


    def self.cache_key_for_all
        count = Game.count
        max_updated_at = Game.maximum(:updated_at).try(:utc).try(:to_s, :number)
        "games/all-#{count}-#{max_updated_at}"
    end
    
    
    def self.for_home
        games = Game.featured
        games += Game.not_featured.random.limit(1) if games.length.even?
        Game.to_sorted games
    end

    
    def self.to_sorted(games)
        games.sort do |a, b|
            a.name.downcase <=> b.name.downcase
        end
    end
end
