module MembersHelper
    def member_avatar(member, options = {})
        unless member.nil? then
            options.symbolize_keys!
            with_handle = options.fetch :handle, true
            
            content = member_avatar_img member, options.fetch(:img, {})
            content += content_tag(:span, member.handle, class: "handle") if with_handle

            link_options = options.fetch :link, {}
            if link_options.is_a? Hash then
                link_options.symbolize_keys!.union! class: ['member-avatar']
                link_to content, member, link_options
            else
                content_tag :div, content, class: 'member-avatar'
            end
        else
            ''
        end
    end

    
    def member_avatar_img(member, options = {})
        image_tag member.avatar.url, options
    end
    
    
    def member_twitch_indicator(member)
        fragment = member.twitch_fragment
        unless fragment.nil? then
            link_to(
                image_tag('external-sites/twitch-avatar-indicator.png'),
                external_link_twitch_channel_url(fragment),
                class: 'twitch_indicator',
                data: {fragment: fragment},
                target: '_blank'
            )
        end
    end

    
    def member_select(f, members = nil, options = {}, html_options = {}, &blk)
        html_options.symbolize_keys!.union! class: ['member-select']
        html_options[:size] = html_options.fetch :size, 6
        members ||= Member.all
        selopts = members.map {|m| [m.handle, m.id]}
        f.select :member_id, selopts, options, html_options, &blk
    end
end
