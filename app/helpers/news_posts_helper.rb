module NewsPostsHelper
    
    def render_news(post, should_render_long = false)
        source = post.short_body
        if should_render_long then
            source += "\n\n"
            source += post.long_body
        end
        render_markdown source
    end
    
end
