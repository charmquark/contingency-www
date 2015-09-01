class BackgroundImagesController < ApplicationController
    BACKGROUNDABLES = {
        game_id:    Game,
        member_id:  Member
    }
    
    redirect_error_msg_table index: ''
    
    

    before_action :set_backgroundable
    around_action :wrap_admin, only: [:new, :create]
    around_action :wrap_admin_or_backgroundable, only: [:index, :destroy]
    
    
    def index
    end
    
    def new
        @background_image = @backgroundable.background_images.build
    end
    
    def create
        @background_image = @backgroundable.background_images.build(
            params.require(:background_image).permit(:image)
        )
        if @background_image.save then
            redirect_to_index 'was successfully added.'
        else
            render :new
        end
    end
    
    def destroy
        @background_image = BackgroundImage.find params[:id]
        @background_image.destroy
        redirect_to_index 'was successfully removed.'
    end
    
    
private


    def enforce_backgroundable_and(condition, &blk)
        condition = !@backgroundable.nil? && condition
        enforce condition, &blk
    end
    
    def redirect_to_index(notice_tail)
        redirect_to(
            polymorphic_path([@backgroundable, BackgroundImage]),
            notice: "The Background #{notice_tail}"
        )
    end

    def set_backgroundable
        BACKGROUNDABLES.each_pair do |key, model|
            if params.has_key?(key) then
                @backgroundable_type = model
                key = @backgroundable_type.model_name.param_key
                @backgroundable = send "find_#{key}", params["#{key}_id".to_sym]
                set_featured_backgroundable @backgroundable
                break
            end
        end
    end
    
    def wrap_admin(&blk)
        admin_only polymorphic_path(@backgroundable), &blk
    end
    
    def wrap_admin_or_backgroundable(&blk)
        admin_or @backgroundable,
            polymorphic_path(@backgroundable),
            redirect_error_msg,
            &blk
    end
end