class GamesController < ApplicationController
    before_action :set_game, only: [:show, :edit, :update, :destroy]

    def index
        @games = Game.all.order :name
    end

    def show
        unless @game.nil? then
            set_featured_background_image @game
            @news_post = NewsPost.where(game: @game).last
        else
            redirect_to games_path
        end
    end

    def new
        admin_only { @game = Game.new }
    end

    def edit
        admin_only do
            set_featured_background_image @game
        end
    end

    def create
        admin_only do
            @game = Game.new game_params
            if @game.save
                redirect_to @game, notice: 'Game was successfully created.'
            else
                render :new
            end
        end
    end

    def update
        admin_only do
            if @game.update(game_params)
                redirect_to @game, notice: 'Game was successfully updated.'
            else
                render :edit
            end
        end
    end

    def destroy
        admin_only do
            @game.destroy
            redirect_to games_url, notice: 'Game was successfully destroyed.'
        end
    end

private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
        @game = find_game params[:id]
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def game_params
        if is_admin? then
            return params.require(:game).permit(:name, :slug, :featured, :banner, :description)
        else
            return params
        end
    end

end
