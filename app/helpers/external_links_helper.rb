module ExternalLinksHelper
    def external_link_icon(el)
        image_tag "external-sites/#{el.site}.png", class: 'external_link-icon', alt: el.site_name
    end
    
    def external_link_resource_url(el, decorate = false)
        frag = el.fragment
        frag = content_tag :span, frag, class: 'fragment' if decorate
        case el.site
        when 'beam_pro'
            "https://beam.pro/#{frag}"
        when 'facebook'
            "https://www.facebook.com/#{frag}"
        when 'gplus'
            "https://plus.google.com/#{frag}/about"
        when 'player_me'
            "https://player.me/#{frag}"
        when 'steam'
            "http://steamcommunity.com/id/#{frag}/"
        when 'twitch'
            "#{external_link_twitch_channel_url frag}/profile"
        when 'twitter'
            "https://twitter.com/#{frag}"
        when 'youtube'
            "https://www.youtube.com/#{frag}"
        when 'www'
            frag
        end
    end
    
    
    def external_link_twitch_channel_url(frag)
        "http://www.twitch.tv/#{frag}"
    end
end