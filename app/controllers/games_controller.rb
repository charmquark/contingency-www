class GamesController < ApplicationController
    before_action :set_game, only: [:show, :edit, :update, :destroy]

    def index
        @games = Game.all.order :name
    end

    def show
    end

    def new
        admin_only { @game = Game.new }
    end

    def edit
        admin_only
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
        # first try finding by slug, then fallback on raw id if needed
        @game = Game.where(slug: params[:id]).first
        @game = Game.find params[:id] if @game.nil?
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
