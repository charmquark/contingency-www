class ExternalLink < ActiveRecord::Base
    SITE_NAMES = {
        twitter:    'Twitter',
        twitch:     'Twitch',
        youtube:    'YouTube',
        www:        'Web'
    }
    
    VALID_SITES = SITE_NAMES.keys.sort
    
    
    belongs_to :member
    
    
    validates :fragment,
        presence: true
    
    validates :member,
        presence: true
    
    validates :site,
        presence: true
    
    
    def to_param
        site
    end
    
    def site_name
        SITE_NAMES[site.to_sym]
    end
    
    def self.available_sites_for(m)
        current = m.external_links.reject {|el| el.site.nil? }.collect {|el| el.site.to_sym }
        VALID_SITES - current
    end
    
    def self.to_sorted(external_links)
        external_links.sort do |a, b|
            a.site <=> b.site
        end
    end
end
