module ExternalLinksHelper
    def external_link_icon(el)
        image_tag "external-sites/#{el.site}.png", class: 'external-site-icon'
    end
    
    def external_link_resource_url(el)
        'http://example.com'
    end
end