class GamesController < ApplicationController
    before_action :set_game, only: [:show, :edit, :update, :destroy]

    def index
    end

    def show
        redirect_to games_path if @game.nil?
    end

    def new
        admin_only games_path do
            @game = Game.new
        end
    end

    def edit
        admin_only games_path
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
        set_featured_background_image @game unless @game.nil?
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
