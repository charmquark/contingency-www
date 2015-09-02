module GamesHelper
    GAME_BANNER_OPTIONS_LINK = {class: ['game-banner']}


    def game_banner(game, options = {})
        unless game.nil? then
            options.symbolize_keys!
            img = game_banner_img game, options.fetch(:img, {})
            link_options = options.fetch :link, {}
            if link_options.is_a? Hash then
                link_options.symbolize_keys!.union! GAME_BANNER_OPTIONS_LINK
                link_to img, game, link_options
            else
                content_tag :div, img, GAME_BANNER_OPTIONS_LINK
            end
        else
            ''
        end
    end
    
    
    def game_banner_img(game = nil, options = {})
        url = game.nil? ? Game::DEFAULT_BANNER_URL : game.banner.url
        image_tag url, options
    end
    
    
    def games_select(f, games = nil, options = {}, html_options = {}, &blk)
        html_options.symbolize_keys!.union! class: ['games-select']
        html_options[:size] = html_options.fetch :size, 6
        games ||= Game.all
        selopts = games.map {|g| [g.name, g.id]}
        f.select :game_id, selopts, options, html_options, &blk
    end
   
end
