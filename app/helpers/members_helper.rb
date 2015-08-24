module MembersHelper
    def member_avatar(member, options = {})
        unless member.nil? then
            options     = options.symbolize_keys
            no_title    = options.fetch :no_title, false
            with_handle = options.fetch :handle, true
            
            img_options         = options.fetch :img, {}
            img_options[:title] = options.fetch :title, member.handle unless with_handle or no_title
            content             = member_avatar_img member, img_options
            
            content += content_tag(:span, member.handle, class: "member-handle") if with_handle

            container_class = "member-avatar member-rank-#{member.rank}"
            
            link_options = options.fetch :link, {}
            if link_options.is_a? Hash then
                link_options            = link_options.symbolize_keys
                link_options[:class]    = "#{container_class} #{link_options.fetch :class, ''}"
                
                link_to content, member, link_options
            else
                content_tag :div, content, class: container_class
            end
        else
            ''
        end
    end
    
    def member_avatar_img(member, options = {})
        options         = options.symbolize_keys
        options[:alt]   = options.fetch(:alt, member.handle)
        
        image_tag member.avatar.url, options
    end
    
    def members_select(f, members = nil)
        members ||= Member.all
        opts = members.sort.map {|m| [m.handle, m.id]}
        f.select :member_id, opts, {}, {size: 6}
    end
end
