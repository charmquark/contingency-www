class NewsPostsController < ApplicationController
    around_action :admin_only, only: [:new, :create, :edit, :update, :destroy]
    before_action :set_news_post, only: [:show, :edit, :update, :destroy]

    def index
    end

    def show
    end

    def new
        @news_post = current_user.news_posts.build
    end

    def create
        @news_post = current_user.news_posts.build news_post_params
        if @news_post.save then
            redirect_to @news_post,
                notice: 'The News Post was successfully added.'
        else
            render :new
        end
    end

    def edit
    end

    def update
        if @news_post.update(news_post_params) then
            redirect_to @news_post,
                notice: 'The News Post was successfully updated.'
        else
            render :edit
        end
    end

    def destroy
        @news_post.destroy
        redirect_to news_posts_path,
            notice: 'The News Post was successfully removed.'
    end

    
private

    def set_news_post
        @news_post = NewsPost.find(params[:id])
    end


    def news_post_params
        params.require(:news_post).permit(:title, :game_id, :short_body, :long_body)
    end
end
