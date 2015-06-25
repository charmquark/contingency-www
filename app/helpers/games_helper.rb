module GamesHelper
    def game_banner(game, img_options = {}, link_options = {})
        class_opt = "game-banner #{game.featured? ? 'game-featured' : ''} "
        
        img_options = img_options.symbolize_keys
        img_options[:alt] = img_options.fetch(:alt, game.name)
        img_options[:class] = class_opt + img_options.fetch(:class, '')
        
        link_options = link_options.symbolize_keys
        link_options[:class] = class_opt + link_options.fetch(:class, '')

        link_to(image_tag(game.banner.url, img_options), game, link_options)
    end
    
    def games_banners(games, img_options = {}, link_options = {})
        games_banners_list(games, img_options, link_options).join('').html_safe
    end
    
    def games_banners_list(games, img_options = {}, link_options = {})
        games.collect do |g|
            game_banner g, img_options.clone, link_options.clone
        end
    end
end
