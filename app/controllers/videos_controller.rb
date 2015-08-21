class VideosController < ApplicationController
    before_action :set_member
    
    def index
        admin_or @member do
            set_featured_background_image @member
            
            @videos = @member.videos
        end
    end
    
    def new
        admin_or @member do
            set_featured_background_image @member
            
            @video = @member.videos.build
        end
    end
    
    def create
        admin_or @member do
            @video = @member.videos.build video_params
            if @video.save then
                redirect_to member_path(@member),
                    notice: 'Video was successfully added.'
            else
                render :new
            end
        end
    end
    
    def destroy
        admin_or @member do
            @video = Video.find_by id: params[:id], member: @member
            @video.destroy
            redirect_to member_videos_path(@member),
                notice: 'Video was successfully removed.'
        end
    end

private

    def set_member
        @member = find_member params[:member_id]
    end
    
    def video_params
        if is_admin_or? @member then
            params.require(:video).permit(:fragment, :game_id)
        else
            params
        end
    end
end

