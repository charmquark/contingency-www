class PagesController < ApplicationController
    def home
        @games = Game.all
        @members = Member.limit 6
    end
end
