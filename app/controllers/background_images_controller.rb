class BackgroundImagesController < ApplicationController
    def index
        @background_images = backgroundable.background_images
        set_featured_background_image
    end
    
    def new
        admin_only do
            @background_image = backgroundable.background_images.build
            set_featured_background_image
        end
    end
    
    def create
        admin_only do
            if backgroundable.background_images.create(background_image_params) then
                redirect_to backgroundable_action_path, notice: 'Background image was successfully created.'
            else
                render :new
            end
        end
    end
    
    def destroy
        admin_only do
            @background_image = BackgroundImage.find params[:id]
            @background_image.destroy
            redirect_to backgroundable_action_path, notice: 'Background image was successfully destroyed.'
        end
    end
    
    helper_method :backgroundable, :backgroundable_action_path, :backgroundable_path

    def backgroundable
        @backgroundable ||= set_backgroundable
    end
    
    def backgroundable_action_path(action = :index, rec = nil)
        rec ||= @background_image
        case backgroundable_type
        when :game
            case action
            when :new
                return new_game_background_image_path(backgroundable)
            when :destroy
                return game_background_image_path(backgroundable, rec)
            else
                return game_background_images_path(backgroundable)
            end
        else
            return nil
        end
    end
    
    def backgroundable_path
        case backgroundable_type
        when :game
            return game_path params[:game_id]
        else
            return root_path
        end
    end
    
private

    def background_image_params
        if is_admin? then
            return params.require(:background_image).permit(:image)
        else
            return params
        end
    end
    
    def backgroundable_type
        @backgroundable_type ||= set_backgroundable_type
    end
    
    def set_backgroundable
        if @backgroundable.nil? then
            case backgroundable_type
            when :game
                @backgroundable = Game.find_by slug: params[:game_id]
            end
        end
        @backgroundable
    end
    
    def set_backgroundable_type
        if @backgroundable_type.nil? then
            @backgroundable_type = :game if params.has_key? :game_id
        end
        @backgroundable_type
    end
    
    def set_featured_background_image
        @featured_background_image = backgroundable.background_images.random.try(:first)
    end
    
end