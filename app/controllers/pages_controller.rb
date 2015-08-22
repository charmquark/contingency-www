class PagesController < ApplicationController
    def home
        @news_post = NewsPost.last
    end
    
    def info
    end
end
