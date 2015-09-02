module MembersHelper
    MEMBER_AVATAR_OPTIONS_LINK = {class: ['member-avatar']}
    
    
    def member_avatar(member, options = {})
        unless member.nil? then
            options.symbolize_keys!
            with_handle = options.fetch :handle, true
            
            content = member_avatar_img member, options.fetch(:img, {})
            content += content_tag(:span, member.handle, class: "member-handle") if with_handle

            link_options = options.fetch :link, {}
            if link_options.is_a? Hash then
                link_options.symbolize_keys!.union! MEMBER_AVATAR_OPTIONS_LINK
                link_to content, member, link_options
            else
                content_tag :div, content, MEMBER_AVATAR_OPTIONS_LINK
            end
        else
            ''
        end
    end

    
    def member_avatar_img(member, options = {})
        url = member.nil? ? Member::DEFAULT_AVATAR_URL : member.avatar.url
        image_tag url, options
    end

    
    def members_select(f, members = nil, options = {}, html_options = {}, &blk)
        html_options.symbolize_keys!.union! class: ['members-select']
        html_options[:size] = html_options.fetch :size, 6
        members ||= Member.all
        selopts = members.map {|m| [m.handle, m.id]}
        f.select :member_id, selopts, options, html_options, &blk
    end
end
