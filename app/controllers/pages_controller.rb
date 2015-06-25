class PagesController < ApplicationController
    def home
        @games = Game.where(featured: true).limit(5)
        @members = Member.to_rank_order(Member.limit(11))
    end
end
