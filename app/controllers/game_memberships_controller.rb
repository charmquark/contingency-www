class GameMembershipsController < ApplicationController
    ASSOCS = {
        game_id:    Game,
        member_id:  Member
    }
    

    around_action :wrap_assoc
    around_action :wrap_admin
    
    
    def new
        @game_membership = @assoc.game_memberships.build
    end
    
    def create
        @game_membership = @assoc.game_memberships.build game_membership_params
        if @game_membership.save then
            redirect_to_assoc 'was successfully added.'
        else
            render :new
        end
    end
    
    def destroy
        @game_membership = GameMembership.find params[:id]
        @game_membership.destroy
        redirect_to_assoc 'was successfully removed.'
    end
    
    
private


    def game_membership_params
        permitted = case @assoc_type.model_name
            when 'Game'
                [:member_id]
            when 'Member'
                [:game_id]
        end
        params.require(:game_membership).permit(*permitted)
    end
    
    def redirect_to_assoc(notice_tail)
        redirect_to(
            @assoc,
            notice: "The Game Membership #{notice_tail}"
        )
    end
    
    def set_assoc
        ASSOCS.each_pair do |key, model|
            if params.has_key? key then
                @assoc_type = model
                key = @assoc_type.model_name.param_key
                @assoc = send "find_#{key}", params["#{key}_id".to_sym]
                set_featured_backgroundable @assoc
                break
            end
        end
    end
    
    def wrap_admin(&blk)
        admin_only @assoc, &blk
    end
    
    def wrap_assoc(&blk)
        set_assoc
        enforce !@assoc.nil?, nil, nil, &blk
    end
end
