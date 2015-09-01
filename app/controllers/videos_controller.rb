class VideosController < ApplicationController
    around_action :wrap_admin_or_member
    around_action :wrap_quota, only: [:new, :create]
    
    
    def index
        @videos = @member.videos
    end
    
    def new
        @video = @member.videos.build
    end
    
    def create
        @video = @member.videos.build video_params
        if @video.save then
            redirect_to member_path(@member),
                notice: 'The Video was successfully added.'
        else
            render :new
        end
    end
    
    def destroy
        @video = Video.find_by id: params[:id], member: @member
        @video.destroy
        redirect_to member_videos_path(@member),
            notice: 'The Video was successfully removed.'
    end


private


    def set_member
        @member = find_member params[:member_id]
        set_featured_backgroundable @member
    end
    
    def video_params
        params.require(:video).permit(:fragment, :game_id)
    end
    
    def wrap_admin_or_member(&blk)
        set_member
        admin_or @member, @member, &blk
    end
    
    def wrap_quota(&blk)
        count = @member.videos.count
        enforce count < Video::MEMBER_QUOTA,
            member_videos_path(@member),
            "The maximum number of Videos per Member has been reached. Please remove one or more Videos from this account before adding any more.",
            &blk
    end
end

