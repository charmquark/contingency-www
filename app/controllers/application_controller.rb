class ApplicationController < ActionController::Base
    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :exception
    
    before_action :current_user
    
    def am_admin_user
        current_user.try(:role_obj) == ContingencyRoles.from_sym(:admin)
    end

    def current_user
        @current_user ||= session[:current_user_id] && Member.find_by(id: session[:current_user_id])
    end

protected

    def admin_only(redir = nil, &blk)
        if am_admin_user then
            yield if block_given?
        else
            flash[:error] = "Permission denied."
            redirect_to(redir.nil? ? root_url : redir)
        end
    end
    
    def admin_or(member, redir = nil, &blk)
        if am_admin_user or (member == @current_user) then
            yield if block_given?
        else
            flash[:error] = "Permission denied."
            redirect_to(redir.nil? ? root_url : redir)
        end
    end
end
