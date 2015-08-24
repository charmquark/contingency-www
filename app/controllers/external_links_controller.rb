class ExternalLinksController < ApplicationController
    before_action :set_member
    before_action :set_external_link, only: [:edit, :update, :destroy]
    
    def index
        admin_or @member
    end
    
    def new
        admin_or @member do
            @external_link = @member.external_links.build
        end
    end
    
    def create
        admin_or @member do
            @external_link = @member.external_links.build(external_link_params(:fragment, :site))
            if @external_link.save then
                redirect_to member_external_links_path(@member), notice: external_link_notice('was successfully added.')
            else
                render :new
            end
        end
    end
    
    def edit
        admin_or @member
    end
    
    def update
        admin_or @member do
            if @external_link.update(external_link_params(:fragment)) then
                redirect_to member_external_links_path(@member), notice: external_link_notice('was successfully updated.')
            else
                render :edit
            end
        end
    end
    
    def destroy
        admin_or @member do
            @external_link.destroy
            redirect_to member_external_links_path(@member), notice: external_link_notice('was successfully deleted.')
        end
    end

private

    def external_link_notice(tail)
        "#{@external_link.site_name} link #{tail}"
    end
    
    def external_link_params(*permitted)
        params.require(:external_link).permit(*permitted)
    end

    def set_external_link
        @external_link = ExternalLink.find_by member: @member, site: params[:id]
    end
    
    def set_member
        @member = find_member params[:member_id]
        set_featured_background_image @member
    end
end