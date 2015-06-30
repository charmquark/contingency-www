class ApplicationController < ActionController::Base
    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :exception
    
    helper_method :current_user, :is_admin?, :logged_in?
    
    def current_user
        @current_user ||= Member.find_by id: session[:current_user_id]
    end
    
    def is_admin?
        current_user.try(:role) == 'admin'
    end

    def logged_in?
        ! current_user.nil?
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
end
