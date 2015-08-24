class ApplicationController < ActionController::Base
    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :exception
    
    before_action :set_current_user

    
    helper_method :featured_background_image, :is_admin?, :is_admin_or?, :logged_in?
    
    def featured_background_image
        @featured_background_image ||= BackgroundImage.random.first
    end
    
    def is_admin?
        @is_admin ||= @current_user.try(:role) == 'admin'
    end
    
    def is_admin_or?(member)
        is_admin? || (member == @current_user)
    end

    def logged_in?
        @logged_in ||= ! @current_user.nil?
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
        if is_admin_or? member then
            yield if block_given?
        else
            flash[:error] = "Permission denied."
            alt_redir = member.nil? ? root_url : member_url(member)
            redirect_to(redir.nil? ? alt_redir : redir)
        end
    end
    
    def find_game(slug)
        Game.find_by slug: slug
    end
    
    def find_member(handle)
        Member.find_by handle: handle
    end
    
    def set_featured_background_image(bgable)
        @featured_background_image = bgable.background_images.random.first unless bgable.nil?
    end

private

    def set_current_user
        user_id = session[:current_user_id]
        @current_user = user_id.nil? ? nil : Member.find(user_id)
    end
end
