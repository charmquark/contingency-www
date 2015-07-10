module BackgroundImagesHelper
    
    def backgroundable_path
        send "#{backgroundable_type}_path", backgroundable
    end
    
    def backgroundable_title
        case backgroundable_type
        when :game
            backgroundable.name
        when :member
            backgroundable.handle
        end
    end
    
    def new_poly_background_image_path
        send "new_#{backgroundable_type}_background_image_path", backgroundable
    end
    
    def poly_background_image_path(rec = nil)
        rec ||= @background_image
        send "#{backgroundable_type}_background_image_path", backgroundable, rec
    end
    
end