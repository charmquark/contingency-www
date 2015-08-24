class SessionsController < ApplicationController
    def new
        session[:current_user_id] = nil
    end

    def create
        unless logged_in? then
            session_params      = params.require(:session).permit(:handle, :password)
            member_handle       = session_params.fetch :handle, nil
            password_candidate  = session_params.fetch :password, nil
            
            member = Member.find_by(handle: member_handle)
            if member.try(:authenticate, password_candidate) then
                session[:current_user_id] = member.id
                flash[:notice] = "You have been logged in as #{member.handle}."
                redirect_to root_url
            else
                flash[:error] = "Login attempt failed."
                redirect_to :back
            end
        else
            flash[:error] = "Already logged in as #{@current_user.handle}."
            redirect_to root_url
        end
    end

    def destroy
        @current_user = session[:current_user_id] = nil
        flash[:notice] = "You have been logged out."
        redirect_to root_url
    end
end
