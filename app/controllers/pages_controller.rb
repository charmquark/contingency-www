class PagesController < ApplicationController
    def home
        @games = Game.featured
        @games += Game.not_featured.random.limit(1) if @games.length.even?
        @games = Game.to_sorted @games

        @members = Member.core
        m = 11 - @members.length
        @members += Member.not_core.random.limit(m) if m > 0
        @members = Member.to_sorted @members
        
        @news_post = NewsPost.last
    end
    
    def info
    end
end
