class Game < ActiveRecord::Base
    scope :featured, -> { where featured: true }
    
    scope :not_featured, -> { where featured: false }
    
    scope :random, -> { order 'random()' }
    
    scope :without_member, ->(m) { Game.to_sorted(all.reject {|r| r.members.include? m }) }

    has_many :background_images, as: :backgroundable
    has_many :game_memberships
    has_many :members, through: :game_memberships
    has_many :news_post
    
    has_attached_file :banner,
        default_url: '/images/generic-game-banner.jpg'
    
    validates :banner,
        attachment_content_type: { content_type: 'image/jpeg' }
    
    validates :name,
        presence: true,
        uniqueness: true
    
    validates :slug,
        presence: true,
        uniqueness: true
    
    def to_param
        slug
    end
    
    def self.to_sorted(games)
        games.sort do |a, b|
            a.name.downcase <=> b.name.downcase
        end
    end
end
