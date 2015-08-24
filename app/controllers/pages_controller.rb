class PagesController < ApplicationController
    def home
        @games = Game.featured
        @games += Game.not_featured.random.limit(1) if @games.length.even?
        @games.sort!
        
        @members = Member.core
        m = (@games.length * 2 + 1) - @members.length
        @members += Member.not_core.random.limit(m) if m > 0
        @members.sort!
        
        @news_post = NewsPost.last
    end
    
    def info
    end
end
