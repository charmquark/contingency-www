class PagesController < ApplicationController
    def home
        @games = Game.where(featured: true).order('random()')
        @members = Member.core.random + Member.not_core.random.limit(10)
        @news_post = NewsPost.last
    end
end
