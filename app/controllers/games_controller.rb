class GamesController < ApplicationController
    around_action :wrap_admin_only, only: [:new, :edit, :create, :update, :destroy]
    before_action :set_game, only: [:show, :edit, :update, :destroy]
    
    def index
    end

    def show
        enforce !@game.nil?, games_path, nil
    end

    def new
        @game = Game.new
    end

    def edit
    end

    def create
        @game = Game.new game_params
        if @game.save
            redirect_to @game, notice: game_notice('was successfully created.')
        else
            render :new
        end
    end

    def update
        if @game.update(game_params)
            redirect_to @game, notice: game_notice('was successfully updated.')
        else
            render :edit
        end
    end

    def destroy
        @game.destroy
        redirect_to games_url, notice: game_notice('was successfully deleted.')
    end


private


    def set_game
        @game = find_game params[:id]
        set_featured_backgroundable @game
    end

    def game_params
        params.require(:game).permit(:name, :slug, :featured, :banner, :description)
    end

    def game_notice(tail)
        "The Game &ldquo;#{game.name}&rdquo; #{tail}"
    end
    
    def wrap_admin_only(&blk)
        admin_only games_path, &blk
    end

end
