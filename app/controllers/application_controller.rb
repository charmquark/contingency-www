class ApplicationController < ActionController::Base
    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :exception
    
    helper_method :current_user, :featured_background_image, :is_admin?, :logged_in?
    
    def current_user
        @current_user ||= Member.find_by id: session[:current_user_id]
    end
    
    def featured_background_image
        @featured_background_image ||= set_default_featured_background_image
    end
    
    def is_admin?
        @is_admin ||= current_user.try(:role) == 'admin'
    end

    def logged_in?
        @logged_in ||= ! current_user.nil?
    end

protected

    def admin_only(redir = nil, &blk)
        if is_admin? then
            yield if block_given?
        else
            flash[:error] = "Permission denied."
            redirect_to(redir.nil? ? root_url : redir)
        end
    end
    
    def admin_or(member, redir = nil, &blk)
        if is_admin? or (member == @current_user) then
            yield if block_given?
        else
            flash[:error] = "Permission denied."
            redirect_to(redir.nil? ? root_url : redir)
        end
    end
    
    def find_game(slug)
        Game.find_by slug: slug
    end
    
    def find_member(handle)
        Member.find_by handle: handle
    end
    
    def set_featured_background_image(bgable)
        unless bgable.nil? then
            bg = bgable.background_images.random
            @featured_background_image = bg[0] if bg.any?
        end
    end

private

    def set_default_featured_background_image
        bg = BackgroundImage.random
        @featured_background_image = bg[0] if bg.any?
    end
end
