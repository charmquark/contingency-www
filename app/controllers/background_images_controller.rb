class BackgroundImagesController < ApplicationController
    BACKGROUNDABLES = {
        game_id:    Game,
        member_id:  Member
    }
    
    
    before_action :set_backgroundable
    
    
    def index
        admin_or backgroundable
    end
    
    def new
        admin_only do
            @background_image = backgroundable.background_images.build
        end
    end
    
    def create
        admin_only do
            @background_image = backgroundable.background_images.build(
                params.require(:background_image).permit(:image)
            )
            if @background_image.save then
                redirect_to polymorphic_path([@backgroundable, BackgroundImage]),
                    notice: 'The Background Image was successfully added.'
            else
                render :new
            end
        end
    end
    
    def destroy
        admin_or backgroundable do
            @background_image = BackgroundImage.find params[:id]
            @background_image.destroy
            redirect_to polymorphic_path([@backgroundable, BackgroundImage]),
                notice: 'The Background Image was successfully destroyed.'
        end
    end
    
    
    helper_method :backgroundable, :backgroundable_type, :backgroundable_type_name

    def backgroundable
        @backgroundable ||= set_backgroundable
    end
    
    def backgroundable_type
        @backgroundable_type
    end
    
    def backgroundable_type_name
        @backgroundable_type_name ||= @backgroundable_type.model_name.param_key
    end

    
private

    def set_backgroundable
        BACKGROUNDABLES.each_pair do |key, model|
            if params.has_key?(key) then
                @backgroundable_type = model
                tn = backgroundable_type_name
                @backgroundable = send "find_#{tn}", params["#{tn}_id".to_sym]
                set_featured_background_image @backgroundable
                break
            end
        end
    end
end