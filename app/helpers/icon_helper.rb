module IconHelper
    ACTION_DELETE_LINK_OPTIONS  = {class: ['danger']}
    ACTION_LINK_TO_OPTIONS      = {class: ['hover-zoom']}
    ICON_DELETE_LINK_OPTIONS    = {
        data:   {confirm: 'Are you sure? This action cannot be undone.'},
        method: :delete
    }

    
    def action_delete_link(text, href, options = {})
        options.symbolize_keys!.union! ACTION_DELETE_LINK_OPTIONS
        action_link_to :delete, text, href, options
    end

    
    def action_link_to(which, text, href, options = {})
        options.symbolize_keys!.union! ACTION_LINK_TO_OPTIONS
        icon_link_to which, text, href, options
    end

    
    def icon(which, options = {})
        options.symbolize_keys!.union! class: "icon icon-#{which}"
        content_tag :span, '', options
    end

    
    def icon_delete_link(text, href, options = {})
        options.symbolize_keys!.union! ICON_DELETE_LINK_OPTIONS
        icon_link_to :delete, text, href, options
    end

    
    def icon_link_to(which, text, href, options = {})
        disp = icon which
        disp += content_tag :span, text, class: 'text' unless text.empty?
        link_to(disp, href, options)
    end

    
    def user_action_icons(condition = true, acts = {}, &blk)
        if condition then
            body = ''
            acts.each_pair do |icn, pth|
                if icn == :delete then
                    body += icon_delete_link '', pth
                else
                    body += icon_link_to icn, '', pth
                end
            end
            body += capture &blk if block_given?
            content_tag :div, body.html_safe, class: 'action-icons'
        else
            ''
        end
    end
end