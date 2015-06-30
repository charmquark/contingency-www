class MembersController < ApplicationController
    before_action :set_member, only: [:show, :edit, :update, :destroy]

    def index
        @members = Member.all.sort {|a, b| a.handle.downcase <=> b.handle.downcase }
    end

    def show
    end

    def new
        admin_only do
            @member = Member.new
            @member.rank = ContingencyRanks::DEFAULT
            @member.role = ContingencyRoles::DEFAULT
        end
    end

    def edit
        admin_or @member
    end

    def create
        admin_only do
            @member = Member.new member_params
            if @member.save
                redirect_to @member, notice: 'Member was successfully created.'
            else
                render :new
            end
        end
    end

    def update
        admin_or @member do
            if @member.update(member_params)
                redirect_to @member, notice: 'Member was successfully updated.'
            else
                render :edit
            end
        end
    end

    def destroy
        admin_only do
            @member.destroy
            redirect_to members_url, notice: 'Member was successfully destroyed.'
        end
    end

private
    # Use callbacks to share common setup or constraints between actions.
    def set_member
        # first try finding by handle, then fallback on raw id if needed
        @member = Member.where(handle: params[:id]).first
        @member = Member.find params[:id] unless @member
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def member_params
        if am_admin_user then
            return params.require(:member).permit(:avatar, :biography, :handle, :email, :password, :password_confirmation, :rank, :role)
        elsif @member == @current_user then
            return params.require(:member).permit(:avatar, :biography, :email, :password, :password_confirmation)
        else
            return params
        end
    end
end
