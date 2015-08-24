class NewsPostsController < ApplicationController
    before_action :set_news_post, only: [:show, :edit, :update, :destroy]

    def index
    end

    def show
    end

    def new
        admin_only do
            @news_post = @current_user.news_posts.build
        end
    end

    def create
        admin_only do
            @news_post = @current_user.news_posts.build news_post_params
            if @news_post.save then
                redirect_to @news_post,
                    notice: 'News post was successfully created.'
            else
                render :new
            end
        end
    end

    def edit
        admin_only
    end

    def update
        admin_only do
            if @news_post.update(news_post_params) then
                redirect_to @news_post,
                    notice: 'News post was successfully updated.'
            else
                render :edit
            end
        end
    end

    def destroy
        admin_only do
            @news_post.destroy
            redirect_to news_posts_url,
                notice: 'News post was successfully destroyed.'
        end
    end

    
private

    def set_news_post
        @news_post = NewsPost.find(params[:id])
    end


    def news_post_params
        params.require(:news_post).permit(:title, :game_id, :short_body, :long_body)
    end
end
