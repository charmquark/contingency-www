class MembersController < ApplicationController
    before_action :set_member, only: [:show, :edit, :update, :destroy]

    # GET /members
    # GET /members.json
    def index
        @members = Member.all
    end

    # GET /members/1
    # GET /members/1.json
    def show
    end

    # GET /members/new
    def new
        admin_only do
            @member = Member.new
            @member.rank = ContingencyRanks::DEFAULT
            @member.role = ContingencyRoles::DEFAULT
        end
    end

    # GET /members/1/edit
    def edit
        admin_or @member
    end

    # POST /members
    # POST /members.json
    def create
        admin_only do
            @member = Member.new(member_params)

            respond_to do |format|
                if @member.save
                    format.html { redirect_to @member, notice: 'Member was successfully created.' }
                    format.json { render :show, status: :created, location: @member }
                else
                    format.html { render :new }
                    format.json { render json: @member.errors, status: :unprocessable_entity }
                end
            end
        end
    end

    # PATCH/PUT /members/1
    # PATCH/PUT /members/1.json
    def update
        admin_or @member do
            respond_to do |format|
                if @member.update(member_params)
                    format.html { redirect_to @member, notice: 'Member was successfully updated.' }
                    format.json { render :show, status: :ok, location: @member }
                else
                    format.html { render :edit }
                    format.json { render json: @member.errors, status: :unprocessable_entity }
                end
            end
        end
    end

    # DELETE /members/1
    # DELETE /members/1.json
    def destroy
        admin_only do
            @member.destroy
            respond_to do |format|
                format.html { redirect_to members_url, notice: 'Member was successfully destroyed.' }
                format.json { head :no_content }
            end
        end
    end

private
    # Use callbacks to share common setup or constraints between actions.
    def set_member
        # first try finding by handle, then fallback on raw id if needed
        @member = Member.where(handle: params[:id]).first
        @member = Member.find params[:id] if @member.nil?
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
