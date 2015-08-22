class ExternalLinksController < ApplicationController
    before_action :set_member
    before_action :set_external_link, only: [:destroy]
    
    def index
        admin_or @member do
            set_featured_background_image @member
        end
    end
    
    def new
        admin_or @member do
            set_featured_background_image @member
            
            @external_link = @member.external_links.build
        end
    end
    
    def create
        admin_or @member do
            @external_link = @member.external_links.build external_link_params
            if @external_link.save then
                redirect_to member_external_links_path(@member), notice: external_link_notice('was successfully added.')
            else
                render :new
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

    def external_link_params
        if is_admin_or? @member then
            params.require(:external_link).permit(:fragment, :site)
        else
            params
        end
    end

    def set_external_link
        @external_link = ExternalLink.find_by member: @member, site: params[:id]
    end
    
    def set_member
        @member = find_member params[:member_id]
    end
end