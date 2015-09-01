class MembersController < ApplicationController
    MEMBER_PERMITTED = [:avatar, :biography, :handle, :email, :password, :password_confirmation]
    ADMIN_PERMITTED = [:rank, :role]
    
    
    around_action :wrap_admin, only: [:new, :create, :destroy]
    before_action :set_member, only: [:show, :edit, :update, :destroy]
    around_action :wrap_admin_or_member, only: [:edit, :update]


    def index
    end

    def show
        enforce !@member.nil?, members_path, nil
    end

    def new
        @member = Member.new
        @member.rank = ContingencyRanks::DEFAULT
        @member.role = ContingencyRoles::DEFAULT
    end

    def create
        @member = Member.new member_params
        if @member.save then
            redirect_to @member, notice: member_notice('was successfully added.')
        else
            render :new
        end
    end

    def edit
    end

    def update
        if @member.update member_params then
            redirect_to @member, notice: member_notice('was successfully updated.')
        else
            render :edit
        end
    end

    def destroy
        @member.destroy
        redirect_to members_path, notice: member_notice('was successfully removed.')
    end

private

    def member_params
        permitted = MEMBER_PERMITTED
        permitted += ADMIN_PERMITTED if is_admin?
        params.require(:member).permit(*permitted)
    end

    def member_notice(tail)
        "The Member &ldquo;#{@member.handle}&rdquo; #{tail}"
    end

    def set_member
        @member = find_member params[:id]
        set_featured_backgroundable @member
    end
    
    def wrap_admin(&blk)
        admin_only members_path, &blk
    end
    
    def wrap_admin_or_member(&blk)
        admin_or @member, @member, &blk
    end
end
