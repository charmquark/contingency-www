module GamesHelper
    def game_banner(game, options = {})
        unless game.nil? then
            options = options.symbolize_keys
            
            img_options = options.fetch(:img, {}).symbolize_keys
            content     = game_banner_img game, img_options
            
            container_class = 'game-banner'
            container_class += ' game-featured' if game.featured
            
            link_options = options.fetch :link, {}
            if link_options.is_a? Hash then
                link_options            = link_options.symbolize_keys
                link_options[:class]    = "#{container_class} #{link_options.fetch :class, ''}"
                
                link_to content, game, link_options
            else
                content_tag :div, content, class: container_class
            end
        else
            ''
        end
    end
    
    def game_banner_img(game = nil, options = {})
        options         = options.symbolize_keys
        options[:alt]   = options.fetch :alt, game.name unless game.nil?
        
        url = game.nil? ? Game::DEFAULT_BANNER_URL : game.banner.url
        
        image_tag url, options
    end
    
    def games_select(f, games = nil, options = {}, html_options = {}, &blk)
        games ||= Game.all
        
        html_options = html_options.symbolize_keys
        html_options[:size] = html_options.fetch :size, 6
        
        so = games.sort.map {|g| [g.name, g.id]}
        f.select :game_id, so, options, html_options, &blk
    end
   
end
