class ApplicationController < ActionController::Base
    DEFAULT_REDIRECT_ERROR_MSG = 'You do not have sufficient permission to do that.'


    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :exception
    
    
    helper_method :current_user, :featured_background_image, :is_admin?, :is_admin_or?, :logged_in?
    
    def current_user
        @current_user ||= set_current_user
    end
    
    def featured_background_image
        @featured_background_image ||= set_featured_background_image
    end
    
    def is_admin?
        @is_admin ||= current_user.try(:is_admin?)
    end
    
    def is_admin_or?(member)
        is_admin? || (member == current_user)
    end

    def logged_in?
        ! current_user.nil?
    end


protected


    def self.redirect_error_msg_table(tab = {})
        const_set 'REDIRECT_ERROR_MSGS', Hash.new(DEFAULT_REDIRECT_ERROR_MSG).update(tab)
    end
    
    def action_symbol
        action_name.to_sym
    end

    def admin_only(redir = nil, msg = DEFAULT_REDIRECT_ERROR_MSG, &blk)
        enforce is_admin?, redir, msg, &blk
    end
    
    def admin_or(member, redir = nil, msg = DEFAULT_REDIRECT_ERROR_MSG, &blk)
        redir ||= member_url(member)
        enforce is_admin_or?(member), redir, msg, &blk
    end
    
    def enforce(condition, redir = nil, msg = DEFAULT_REDIRECT_ERROR_MSG, &blk)
        if condition then
            yield if block_given?
        else
            flash[:error] = msg unless msg.blank?
            redir ||= root_url
            redirect_to redir
        end
    end
    
    def find_game(slug)
        Game.find_by slug: slug
    end
    
    def find_member(handle)
        Member.find_by handle: handle
    end
    
    def redirect_error_msg
        self.class::REDIRECT_ERROR_MSGS[action_symbol]
    end
    
    def set_featured_background_image
        unless @featured_backgroundable.nil? then
            @featured_background_image = @featured_backgroundable.background_images.random.first
        end
        @featured_background_image = BackgroundImage.random.first if @featured_background_image.nil?
        @featured_background_image
    end
    
    def set_featured_backgroundable(bgable)
        @featured_backgroundable = bgable
    end


private


    def set_current_user
        user_id = session[:current_user_id]
        @current_user = user_id.nil? ? nil : Member.find(user_id)
    end
end
