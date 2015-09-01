class ExternalLinksController < ApplicationController
    around_action :wrap_admin_or_member
    before_action :set_external_link, only: [:edit, :update, :destroy]
    
    redirect_error_msg_table index: ''

    
    def index
    end
    
    def new
        @external_link = @member.external_links.build
    end
    
    def create
        @external_link = @member.external_links.build(external_link_params(:fragment, :site))
        if @external_link.save then
            redirect_to_index 'was successfully added.'
        else
            render :new
        end
    end
    
    def edit
    end
    
    def update
        if @external_link.update(external_link_params(:fragment)) then
            redirect_to_index 'was successfully updated.'
        else
            render :edit
        end
    end
    
    def destroy
        @external_link.destroy
        redirect_to_index 'was successfully removed.'
    end


private


    def external_link_params(*permitted)
        params.require(:external_link).permit(*permitted)
    end
    
    def redirect_to_index(notice_tail)
        redirect_to(
            member_external_links_path(@member),
            notice: "#{@external_link.site_name} link #{notice_tail}"
        )
    end

    def set_external_link
        @external_link = ExternalLink.find_by member: @member, site: params[:id]
    end
    
    def set_member
        @member = find_member params[:member_id]
        set_featured_backgroundable @member
    end
    
    def wrap_admin_or_member(&blk)
        set_member
        admin_or @member,
            @member,
            redirect_error_msg,
            &blk
    end
end