class MembersController < ApplicationController
    MEMBER_PERMITTED = [:avatar, :biography, :handle, :email, :password, :password_confirmation]
    ADMIN_PERMITTED = [:rank, :role]
    
    
    before_action :set_member, only: [:show, :edit, :update, :destroy]


    def index
    end

    def show
        redirect_to members_path if @member.nil?
    end

    def new
        admin_only members_path do
            @member = Member.new
            @member.rank = ContingencyRanks::DEFAULT
            @member.role = ContingencyRoles::DEFAULT
        end
    end

    def edit
        admin_or @member
    end

    def create
        admin_only members_path do
            @member = Member.new member_params
            if @member.save then
                redirect_to @member, notice: member_notice('was successfully created.')
            else
                render :new
            end
        end
    end

    def update
        admin_or @member do
            if @member.update member_params then
                redirect_to @member, notice: member_notice('was successfully updated.')
            else
                render :edit
            end
        end
    end

    def destroy
        admin_only members_path do
            @member.destroy
            redirect_to members_url, notice: member_notice('was successfully deleted.')
        end
    end

private

    def member_params
        permitted = MEMBER_PERMITTED
        permitted += ADMIN_PERMITTED if is_admin?
        params.require(:member).permit(permitted)
    end

    def member_notice(tail)
        "The Member &ldquo;#{@member.handle}&rdquo; #{tail}"
    end

    def set_member
        @member = find_member params[:id]
        set_featured_background_image @member unless @member.nil?
    end
end
