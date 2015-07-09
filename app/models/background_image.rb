class BackgroundImage < ActiveRecord::Base
    
    scope :random, -> { order('random()').limit(1) }
    
    belongs_to :backgroundable, polymorphic: true
    
    has_attached_file :image,
        default_url: ''
    
    validates :backgroundable,
        presence: true
    
    validates :image,
        attachment_presence: true,
        attachment_content_type: {content_type: 'image/png'}
end
