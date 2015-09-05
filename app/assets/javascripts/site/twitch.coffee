$(document).on 'page:change', ->
    $('#member_show_twitch-preview').each ->
        preview = $ this
        twitch_fetch
            url: twitch_data_url_for preview
            success: (data, textStatus, jqXHR)->
                if data.stream?
                    stream = data.stream
                    preview.prepend $("<img class='thumbnail' src='#{stream.preview.medium}' />")
                    $('.title', preview).text stream.channel.status
                    $('.game', preview).text stream.game
                    $('.viewers', preview).text stream.viewers
                    preview.addClass 'show'
    
    $('.twitch-indicator').each ->
        indicator = $ this
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
