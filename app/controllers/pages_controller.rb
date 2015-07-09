class PagesController < ApplicationController
    def home
        @games = Game.featured.random
        @members = Member.core.random + Member.not_core.random.limit(10)
        @news_post = NewsPost.last
    end
end
