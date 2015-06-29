class PagesController < ApplicationController
    def home
        @games = Game.where(featured: true)
        @members = Member.core + Member.not_core.limit(10)
        @news_post = NewsPost.last
    end
end
