class SessionsController < ApplicationController
    around_action :wrap_not_logged_in, only: [:new, :create]
    
    
    def new
        session[:current_user_id] = nil
    end

    def create
        session_params = params.require(:session).permit(:handle, :password)
        member = find_member session_params.fetch(:handle, nil)
        if member.try(:authenticate, session_params.fetch(:password, nil)) then
            login_user member
            redirect_to root_path, notice: "You have logged in as #{member.handle}."
        else
            redirect_to root_path, flash: {error: "Login attempt failed."}
        end
    end

    def destroy
        enforce logged_in?, nil, nil do
            logout_user
            redirect_to root_path, notice: "You have been logged out."
        end
    end
    
    
private


    def wrap_not_logged_in(&blk)
        enforce !logged_in?,
            root_path,
            "You are already logged in. To switch accounts, logout first.",
            &blk
    end
end
