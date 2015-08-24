class GameMembershipsController < ApplicationController
    ASSOCS = {
        game_id:    Game,
        member_id:  Member
    }
    
    PERMITTED = {
        'game'      => [:member_id],
        'member'    => [:game_id]
    }
    
    
    before_action :set_assoc
    
    
    def new
        admin_only do
            @game_membership = @assoc.game_memberships.build
        end
    end
    
    def create
        admin_only do
            @game_membership = @assoc.game_memberships.build game_membership_params
            if @game_membership.save then
                redirect_to polymorphic_path(@assoc), notice: 'Game Membership successfully added.'
            else
                render :new
            end
        end
    end
    
    def destroy
        admin_only do
            @game_membership = GameMembership.find params[:id]
            @game_membership.destroy
            redirect_to polymorphic_path(@assoc), notice: 'Game Membership successfully removed.'
        end
    end
    
    helper_method :assoc_type
    
    def assoc_type
        @assoc_type
    end
    
    def assoc_type_name
        @assoc_type_name ||= @assoc_type.model_name.param_key
    end

private

    def game_membership_params
        params.require(:game_membership).permit(*(PERMITTED[assoc_type_name]))
    end
    
    def set_assoc
        ASSOCS.each_pair do |key, model|
            if params.has_key? key then
                @assoc_type = model
                tn = assoc_type_name
                @assoc = send "find_#{tn}", params["#{tn}_id".to_sym]
                set_featured_background_image @assoc
                break
            end
        end
    end
end
