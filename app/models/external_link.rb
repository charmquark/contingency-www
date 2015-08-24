class ExternalLink < ActiveRecord::Base
    SITE_NAMES = {
        beam_pro:   'Beam',
        facebook:   'Facebook',
        gplus:      'Google+',
        player_me:  'Player.me',
        steam:      'Steam',
        twitter:    'Twitter',
        twitch:     'Twitch',
        youtube:    'YouTube',
        www:        'Web'
    }
    
    VALID_SITES = SITE_NAMES.keys.map(&:to_s).sort
    
    
    belongs_to :member,
        touch: true
    
    
    validates :fragment,
        presence: true
    
    validates :member,
        presence: true
    
    validates :site,
        presence: true
    
    
    def <=>(other_el)
        site <=> other_el.site
    end
    
    def to_param
        site
    end
    
    def site_name
        SITE_NAMES[site.to_sym]
    end
    
    def self.available_sites_for(member)
        VALID_SITES - member.external_links.map(&:site)
    end
end
