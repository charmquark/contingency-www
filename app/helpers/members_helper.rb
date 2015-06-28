module MembersHelper
    def member_avatar(member, options = {})
        options     = options.symbolize_keys
        with_handle = options.fetch(:handle, true)
        
        img_options         = options.fetch :img, {}
        img_options[:title] = options.fetch :title, member.handle unless with_handle
        content             = member_avatar_img member, img_options
        
        content += content_tag(:span, member.handle, class: "member-handle") if with_handle

        link_classes            = "member-avatar member-rank-#{member.rank} "
        link_options            = options.fetch :link, {}
        link_options[:class]    = link_classes + link_options.fetch(:class, '')
        link_to content, member, link_options
    end
    
    def member_avatar_img(member, options = {})
        options         = options.symbolize_keys
        options[:alt]   = options.fetch(:alt, member.handle)
        
        image_tag member.avatar.url, options
    end
    
    def members_avatars(members, img_options = {}, link_options = {})
        members_avatars_list(members, img_options, link_options).join('').html_safe
    end
    
    def members_avatars_list(members, img_options = {}, link_options = {})
        members.collect do |m|
            member_avatar m, img_options.clone, link_options.clone
        end
    end
end
