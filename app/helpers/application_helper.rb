module ApplicationHelper
    def admin_only(&blk)
        yield if is_admin?
    end
    
    def admin_or(member, &blk)
        yield if is_admin? or member == current_user
    end
    
    def content_row(bp, style = :halfs, options = {}, &blk)
        options = options.symbolize_keys
        options[:class] = "row-#{bp} row-of-#{style} #{options.fetch :class, ''}"
        body = block_given? ? capture(&blk) : ''
        content_tag :span, body, options
    end
    
    def content_section(id = nil, options = {}, &blk)
        options = options.symbolize_keys
        options[:id] = "#{id}-section" unless id.nil?
        options[:class] = "content-section #{options.fetch :class, ''}"
        
        title = options.delete :title
        body = title.nil? ? '' : content_tag(:h2, title.html_safe)
        body += block_given? ? capture(&blk) : ''
        
        body = content_tag :div, body.html_safe, class: 'content-section-body'
        content_tag :section, body.html_safe, options
    end
    
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
    
    def icon_delete_link(color, text, href, options = {})
        options = options.symbolize_keys
        options[:data] = {:confirm => 'Are you sure?'}
        options[:method] = :delete
        icon_link_to color, :delete, text, href, options
    end
    
    def icon_link_to(color, which, text, href, options = {})
        link_to(icon(color, which) + content_tag(:span, text, class: 'text'), href, options)
    end
    
    def render_markdown(source)
        markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML,
            no_intra_emphasis: true
        )
        markdown.render(source).html_safe
    end
    
    def with_user(&blk)
        yield unless @current_user.nil?
    end
end
