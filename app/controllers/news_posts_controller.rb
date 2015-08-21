class NewsPostsController < ApplicationController
    before_action :set_news_post, only: [:show, :edit, :update, :destroy]

    # GET /news_posts
    # GET /news_posts.json
    def index
        @news_posts = NewsPost.order(created_at: :desc).limit(8)
    end

    # GET /news_posts/1
    # GET /news_posts/1.json
    def show
    end

    # GET /news_posts/new
    def new
        admin_only do
            create_news_post
        end
    end

    # GET /news_posts/1/edit
    def edit
        admin_only
    end

    # POST /news_posts
    # POST /news_posts.json
    def create
        admin_only do
            create_news_post news_post_params
            if @news_post.save then
                redirect_to @news_post,
                    notice: 'News post was successfully created.'
            else
                render :new
            end
        end
    end

    # PATCH/PUT /news_posts/1
    # PATCH/PUT /news_posts/1.json
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

    # DELETE /news_posts/1
    # DELETE /news_posts/1.json
    def destroy
        admin_only do
            @news_post.destroy
            redirect_to news_posts_url,
                notice: 'News post was successfully destroyed.'
        end
    end

private
    def create_news_post(p = {})
        @news_post = NewsPost.new p
        @news_post.member = current_user
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_news_post
        @news_post = NewsPost.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def news_post_params
        if is_admin? then
            return params.require(:news_post).permit(*NewsPost::PERMITTED)
        else
            return params
        end
    end
end
