class Game < ActiveRecord::Base
    scope :random, -> { order 'random()' }
    
    has_attached_file :banner,
        default_url: ''
    
    validates :banner,
        attachment_presence: true,
        attachment_content_type: { content_type: 'image/jpeg' }
    
    validates :name,
        presence: true,
        uniqueness: true
    
    validates :slug,
        presence: true,
        uniqueness: true
    
    validates :summary,
        presence: true

    has_many :news_post
    
    def to_param
        slug
    end
end
