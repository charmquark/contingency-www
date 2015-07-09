class GameMembershipsController < ApplicationController
    def index
        set_featured_background_image assoc
        #@game_memberships = assoc.game_memberships
    end
    
    def new
        admin_only do
            set_featured_background_image assoc
            @game_membership = assoc.game_memberships.build
        end
    end
    
    def create
        admin_only do
            set_featured_background_image assoc
            @game_membership = assoc.game_memberships.build game_membership_params
            if @game_membership.save then
                redirect_to assoc_game_membership_path,
                    notice: 'Game membership successfully saved.'
            else
                render :new
            end
        end
    end
    
    helper_method :assoc, :assoc_game_membership_path, :assoc_type
    
    def assoc
        @assoc ||= set_assoc
    end

    def assoc_game_membership_path
        send "#{assoc_type}_game_memberships_path", assoc
    end
    
    def assoc_type
        @assoc_type ||= set_assoc_type
    end

private

    def game_membership_params
        case assoc_type
        when :game
            return params.require(:game_membership).permit(:member_id)
        when :member
            return params.require(:game_membership).permit(:game_id)
        else
            return params
        end
    end
    
    def set_assoc
        case assoc_type
        when :game
            @assoc = find_game params[:game_id]
        when :member
            @assoc = find_member params[:member_id]
        end
        @assoc
    end

    def set_assoc_type
        if @assoc_type.nil? then
            @assoc_type = :game    if params.has_key? 'game_id'
            @assoc_type = :member  if params.has_key? 'member_id'
        end
        @assoc_type
    end
end
