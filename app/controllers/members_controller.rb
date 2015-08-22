class MembersController < ApplicationController
    before_action :set_member, only: [:show, :edit, :update, :destroy]

    def index
        @members = Member.to_sorted Member.all
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
            if @member.save
                redirect_to @member, notice: member_notice('was successfully created.')
            else
                render :new
            end
        end
    end

    def update
        admin_or @member do
            if @member.update(member_params)
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
    # Use callbacks to share common setup or constraints between actions.
    def set_member
        @member = find_member params[:id]
        set_featured_background_image @member unless @member.nil?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def member_params
        if is_admin? then
            return params.require(:member).permit(:avatar, :biography, :handle, :email, :password, :password_confirmation, :rank, :role)
        elsif @member == current_user then
            return params.require(:member).permit(:avatar, :biography, :handle, :email, :password, :password_confirmation)
        else
            return params
        end
    end

    def member_notice(tail)
        "The Member &ldquo;#{@member.handle}&rdquo; #{tail}"
    end
end
