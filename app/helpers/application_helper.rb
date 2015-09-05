module ApplicationHelper
    def content_row(bp, style = :halfs, options = {}, &blk)
        options.symbolize_keys!.union! class: ["row_#{bp} row_of_#{style}"]
        body = block_given? ? capture(&blk) : ''
        content_tag :span, body, options
    end
    
    
    def content_section(id, options = {}, &blk)
        options.symbolize_keys!.union! class: ['content_section']
        options[:id] = "#{id}-section" unless id.nil?
        
        title = options.delete :title
        body = title.nil? ? '' : content_tag(:h2, title.html_safe)
        body += block_given? ? capture(&blk) : ''
        
        body = content_tag :div, body.html_safe, class: 'content_section-body' if options.fetch(:body, true)
        content_tag :section, body, options
    end
    
    
    def form_actions(f, cancel_action)
        user_actions do
            content = f.submit 'Save'
            content += f.button 'Reset', type: :reset
            content += link_to 'Cancel', cancel_action
            content += yield if block_given?
            content
        end
    end

    
    def form_section(options = {}, &blk)
        options.symbolize_keys!.union! class: ['limit_medium']
        content_section :form, options, &blk
    end

    
    def render_markdown(source)
        $markdown.render(source).html_safe
    end

    
    def title(*text_items)
        text_items.each do |text|
            content_for :title, "#{text} | "
        end
    end
    

    def user_actions(condition = true, acts = {}, &blk)
        if condition then
            body = ''
            acts.each_pair do |icn, lnk|
                txt, pth = *lnk
                if icn == :delete then
                    body += icon_delete_link txt, pth
                else
                    body += icon_link_to icn, txt, pth
                end
            end
            body += capture &blk if block_given?
            content_tag(:div, '', class: 'clear') + content_tag(:div, body.html_safe, class: 'actions')
        else
            ''
        end
    end
end
