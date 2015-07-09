class Game < ActiveRecord::Base
    scope :random, -> { order 'random()' }

    has_many :background_images, as: :backgroundable
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
end
