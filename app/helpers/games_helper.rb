module GamesHelper
    def game_banner(game, options = {})
        options = options.symbolize_keys
        
        img_options = options.fetch :img, {}
        content     = game_banner_img game, img_options
        
        link_classes            = "game-banner #{game.featured ? 'game-featured' : ''} "
        link_options            = options.fetch :link, {}
        link_options[:class]    = link_classes + link_options.fetch(:class, '')
        link_to content, game, link_options
    end
    
    def game_banner_img(game, options = {})
        options         = options.symbolize_keys
        options[:alt]   = options.fetch :alt, game.name
        
        image_tag game.banner.url, options
    end
    
    def games_banners(games, img_options = {}, link_options = {})
        games_banners_list(games, img_options, link_options).join('').html_safe
    end
    
    def games_banners_list(games, img_options = {}, link_options = {})
        games.collect do |g|
            game_banner g, img: img_options.clone, link: link_options.clone
        end
    end
end
