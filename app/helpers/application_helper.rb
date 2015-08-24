module ApplicationHelper
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
    
    def form_section(options = {}, &blk)
        options = options.symbolize_keys
        options[:class] = "limit-medium #{options.fetch :class, ''}"
        
        content_section :form, options, &blk
    end
    
    def icon(color, which, options = {})
        options = options.symbolize_keys
        options[:class] = "icon icon-#{color} icon-#{which} " + options.fetch(:class, '')
        content_tag :span, '', options
    end
    
    def icon_delete_link(color, text, href, options = {})
        options = options.symbolize_keys
        options[:data] = {:confirm => 'Are you sure? This deletion cannot be undone.'}
        options[:method] = :delete
        icon_link_to color, :delete, text, href, options
    end
    
    def icon_link_to(color, which, text, href, options = {})
        disp = icon color, which
        disp += content_tag :span, text, class: 'text' unless text.empty?
        link_to(disp, href, options)
    end
    
    def render_markdown(source)
        markdown = Redcarpet::Markdown.new Redcarpet::Render::HTML, no_intra_emphasis: true
        markdown.render(source).html_safe
    end
    
    def user_actions(condition = true, &blk)
        if condition then
            body = block_given? ? capture(&blk) : ''
            content_tag :div, body, class: 'actions'
        else
            ''
        end
    end
    
    def user_action_icons(condition = true, acts = {}, &blk)
        if condition then
            body = ''
            acts.each_pair do |icn, pth|
                body += icon_link_to :white, icn, '', pth
            end
            body += capture &blk if block_given?
            content_tag :div, body.html_safe, class: 'action-icons'
        else
            ''
        end
    end
end
