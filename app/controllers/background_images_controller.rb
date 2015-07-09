class BackgroundImagesController < ApplicationController
    
    def index
        set_featured_background_image backgroundable
        @background_images = backgroundable.background_images
    end
    
    def new
        admin_only do
            set_featured_background_image backgroundable
            @background_image = backgroundable.background_images.build
        end
    end
    
    def create
        admin_only do
            set_featured_background_image backgroundable
            @background_image = backgroundable.background_images.build background_image_params
            if @background_image.save then
                redirect_to poly_background_images_path,
                    notice: 'Background image was successfully created.'
            else
                render :new
            end
        end
    end
    
    def destroy
        admin_only do
            set_featured_background_image backgroundable
            @background_image = BackgroundImage.find params[:id]
            @background_image.destroy
            redirect_to poly_background_images_path,
                notice: 'Background image was successfully destroyed.'
        end
    end
    
    helper_method :backgroundable, :backgroundable_type, :poly_background_images_path

    def backgroundable
        @backgroundable ||= set_backgroundable
    end
    
    def backgroundable_type
        @backgroundable_type ||= set_backgroundable_type
    end
    
    def poly_background_images_path
        send "#{backgroundable_type}_background_images_path", backgroundable
    end
        
private

    def background_image_params
        safe = false
        case backgroundable_type
        when :game
            safe = is_admin?
        when :member
            safe = is_admin? or backgroundable == current_user
        end
        
        if safe then
            return params.require(:background_image).permit(:image)
        else
            return params
        end
    end
    
    def set_backgroundable
        if @backgroundable.nil? then
            case backgroundable_type
            when :game
                @backgroundable = find_game params[:game_id]
            when :member
                @backgroundable = find_member params[:member_id]
            end
        end
        @backgroundable
    end
    
    def set_backgroundable_type
        if @backgroundable_type.nil? then
            @backgroundable_type = :game    if params.has_key? :game_id
            @backgroundable_type = :member  if params.has_key? :member_id
        end
        @backgroundable_type
    end
    
end