module GamesHelper
    def game_banner(game = nil, options = {})
        options = options.symbolize_keys
        
        img_options = options.fetch(:img, {}).symbolize_keys
        content     = game_banner_img game, img_options
        
        link_options = options.fetch(:link, {}).symbolize_keys

        link_classes            = "game-banner"
        link_classes            = "#{link_classes} #{game.featured ? 'game-featured' : ''}" unless game.nil?
        link_options[:class]    = "#{link_classes} #{link_options.fetch :class, ''}"
        
        unless game.nil? then
            link_to content, game, link_options
        else
            link_to content, games_path, link_options
        end
    end
    
    def game_banner_img(game = nil, options = {})
        options         = options.symbolize_keys
        options[:alt]   = options.fetch :alt, game.name unless game.nil?
        
        url = game.nil? ? Game::DEFAULT_BANNER_URL : game.banner.url
        
        image_tag url, options
    end
    
    def games_banners(games, img_options = {}, link_options = {})
        games_banners_list(games, img_options, link_options).join('').html_safe
    end
    
    def games_banners_list(games, img_options = {}, link_options = {})
        games.collect do |g|
            game_banner g, img: img_options.clone, link: link_options.clone
        end
    end
    
    def games_select(f, games = nil, options = {}, html_options = {}, &blk)
        games ||= Game.all
        
        html_options = html_options.symbolize_keys
        html_options[:size] = html_options.fetch :size, 6
        
        so = Game.to_sorted(games).map {|g| [g.name, g.id]}
        f.select :game_id, so, options, html_options, &blk
    end
    
end
