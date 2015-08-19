class PagesController < ApplicationController
    def home
        @games = Game.to_sorted Game.featured

        @members = Member.core
        nc = (@games.length * 2) - @members.length
        nc = 2 if nc <= 0
        @members = Member.to_sorted(@members + Member.not_core.random.limit(nc))
        
        @news_post = NewsPost.last
    end
end
