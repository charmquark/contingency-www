module ApplicationHelper
    CONTENT_SECTION_OPTIONS = {class: ['content-section']}
    FORM_SECTION_OPTIONS    = {class: ['limit-medium']}
    
    
    def content_row(bp, style = :halfs, options = {}, &blk)
        options.symbolize_keys!.union! class: "row-#{bp} row-of-#{style}"
        body = block_given? ? capture(&blk) : ''
        content_tag :span, body, options
    end
    
    
    def content_section(id = nil, options = {}, &blk)
        options.symbolize_keys!.union! CONTENT_SECTION_OPTIONS
        options[:id] = "#{id}-section" unless id.nil?
        
        title = options.delete :title
        body = title.nil? ? '' : content_tag(:h2, title.html_safe)
        body += block_given? ? capture(&blk) : ''
        
        body = content_tag :div, body.html_safe, class: 'content-section-body'
        content_tag :section, body, options
    end
    
    def form_section(options = {}, &blk)
        options.symbolize_keys!.union! FORM_SECTION_OPTIONS
        content_section :form, options, &blk
    end
    
    def render_markdown(source)
        $markdown.render(source).html_safe
    end
    
    def user_actions(condition = true, &blk)
        if condition then
            body = block_given? ? capture(&blk) : ''
            content_tag :div, body, class: 'actions'
        else
            ''
        end
    end
end
