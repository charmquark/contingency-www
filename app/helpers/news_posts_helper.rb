module NewsPostsHelper
    
    def render_news(post, should_render_long = false)
        markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML,
            no_intra_emphasis: true
        )
        source = post.short_body
        if should_render_long then
            source += "\n\n"
            source += post.long_body
        end
        markdown.render(source).html_safe
    end
    
end
