module MembersHelper
    def member_avatar(member, img_options = {}, link_options = {})
        img_options = img_options.symbolize_keys
        img_options[:alt]   = img_options.fetch(:alt, member.handle)
        img_options[:class] = img_options.fetch(:class, '') + ' member-avatar'
        img_options[:size]  = Member::AVATAR_SIZES[img_options.fetch(:size, :normal)]
        
        link_options.symbolize_keys
        link_options[:class] = link_options.fetch(:class, '') + " member #{member_rank_class member}"
        
        link_to(image_tag(member.avatar.url, img_options), member, link_options)
    end
    
    def member_rank_class(member)
        'member-rank-' + member.rank
    end
    
    def members_to_rank_groups(members)
        result = Hash.new {|hash, key| hash[key] = [] }
        members.each do |member|
            result[member.rank] << member
        end
        result
    end
end
