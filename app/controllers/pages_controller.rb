class PagesController < ApplicationController
    def home
        @games = Game.featured
        g = ((@games.length % 3) - 2).abs
        @games += Game.not_featured.random.limit(g) if g > 0
        @games = @games.sort
        
        @members = Member.core
        m = (@games.length * 2 + 1) - @members.length
        @members += Member.not_core.random.limit(m) if m > 0
        @members = @members.sort
        
        @news_post = NewsPost.last
    end
    
    def manual
    end
end


