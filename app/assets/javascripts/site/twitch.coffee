$(document).on 'page:change', ->
    $('.member-twitch-indicator').each ->
        indicator = $ this
        twitch_fetch
            url: twitch_data_url_for indicator
            success: (data, textStatus, jqXHR)->
                if data.stream?
                    stream = data.stream
                    indicator.prepend $("<img class='twitch-info-preview' src='#{stream.preview.medium}' />")
                    $('.twitch-info-game', indicator).text stream.game
                    $('.twitch-info-title', indicator).text stream.channel.status
                    $('.twitch-info-viewers', indicator).text stream.viewers
                    indicator.addClass 'show'
    
    $('.member-avatar-twitch-indicator').each ->
        indicator = $ this
        fragment = indicator.data 'fragment'
        twitch_fetch
            url: twitch_data_url_for indicator
            success: (data, textStatus, jqXHR)->
                if data.stream?
                    indicator.addClass 'show'


twitch_data_url_for = (indicator)->
    fragment = indicator.data 'fragment'
    "https://api.twitch.tv/kraken/streams/#{fragment}"


twitch_fetch = (options)->
    options.cache = false
    options.dataType = 'jsonp'
    $.ajax options
