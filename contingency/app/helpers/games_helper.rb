module GamesHelper
    def game_banner(game, img_options = {}, link_options = {})
        img_options = img_options.symbolize_keys
        img_options[:alt]   = img_options.fetch(:alt, game.name)
        img_options[:class] = img_options.fetch(:class, '') + ' game-banner'
        img_options[:size]  = Game::BANNER_SIZES[img_options.fetch(:size, :normal)]
        
        link_options.symbolize_keys
        link_options[:class] = link_options.fetch(:class, '') + " game"
        
        link_to(image_tag(game.banner.url, img_options), game, link_options)
    end
end
