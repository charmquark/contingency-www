class GamesController < ApplicationController
    before_action :set_game, only: [:show, :edit, :update, :destroy]

    def index
        @games = Game.to_sorted Game.all
    end

    def show
        unless @game.nil? then
            set_featured_background_image @game
            @news_post = NewsPost.where(game: @game).last
            @members = Member.to_sorted @game.members
        else
            redirect_to games_path
        end
    end

    def new
        admin_only(games_path) { @game = Game.new }
    end

    def edit
        admin_only games_path do
            set_featured_background_image @game
        end
    end

    def create
        admin_only games_path do
            @game = Game.new game_params
            if @game.save
                redirect_to @game, notice: game_notice('was successfully created.')
            else
                render :new
            end
        end
    end

    def update
        admin_only games_path do
            if @game.update(game_params)
                redirect_to @game, notice: game_notice('was successfully updated.')
            else
                render :edit
            end
        end
    end

    def destroy
        admin_only games_path do
            @game.destroy
            redirect_to games_url, notice: game_notice('was successfully deleted.')
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

    def game_notice(tail)
        "The Game &ldquo;#{@game.name}&rdquo; #{tail}"
    end
end
