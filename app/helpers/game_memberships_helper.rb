module GameMembershipsHelper
    def game_memberships_sorted(assoc)
        gms = assoc.game_memberships
        case assoc.model_name
        when 'Game'
            gms.includes(:member).sort {|a, b| a.member <=> b.member }
        when 'Member'
            gms.includes(:game).sort {|a, b| a.game <=> b.game }
        end
    end
    
    def render_game_membership(assoc, gm)
        case assoc.model_name
        when 'Game'
            member_avatar gm.member
        when 'Member'
            game_banner gm.game
        end
    end
end
