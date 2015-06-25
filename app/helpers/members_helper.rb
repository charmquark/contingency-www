module MembersHelper
    def member_avatar(member, img_options = {}, link_options = {})
        handle      = member.handle
        class_opt   = "member-avatar membar-rank-#{member.rank}"
        
        img_options = img_options.symbolize_keys
        img_options[:alt] = img_options.fetch(:alt, handle)
        img_options[:class] = class_opt + img_options.fetch(:class, '')
        img_options[:title] = img_options.fetch(:title, handle)
        
        link_options = link_options.symbolize_keys
        link_options[:class] = class_opt + link_options.fetch(:class, '')
        
        link_to(image_tag(member.avatar.url, img_options) + content_tag(:span, member.handle, class: 'member-handle'), member, link_options)
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
