module GamesHelper
    def game_banner(game)
        link_to image_tag(game.banner.url, class: 'game-banner', size: '250x125', alt: game.name), game
    end
end
