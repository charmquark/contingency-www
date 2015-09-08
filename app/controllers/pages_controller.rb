class PagesController < ApplicationController
    def home
        @games = Game.unscoped.featured
        g = ((@games.length % 3) - 2).abs
        @games += Game.unscoped.not_featured.random.limit(g) if g > 0
        @games = @games.sort
        
        @members = Member.unscoped.core
        m = (@games.length * 2 + 1) - @members.length
        @members += Member.unscoped.not_core.random.limit(m) if m > 0
        @members = @members.sort
        
        @news_post = NewsPost.last
    end
    
    def manual
    end
end


