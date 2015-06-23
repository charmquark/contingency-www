module ApplicationHelper
    def icon(color, which, options = {})
        options = options.symbolize_keys
        options[:class] = "icon icon-#{color} icon-#{which} " + options.fetch(:class, '')
        content_tag :span, '', options
    end
    
    def icon_2x(color, which, options = {})
        options = options.symbolize_keys
        options[:class] = options.fetch(:class, '') + ' icon-2x'
        icon which, options
    end
end
