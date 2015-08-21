API_KEY = 'AIzaSyAdhT31R8iKdm394RqKzdU_J00K5OHYyxw'

$(document).on 'page:change', ->
    info_instances = {}
    ids = []
    $('[data-youtube-info]').each ->
        container = $ this
        fragment = container.data 'youtube-info'
        info_instances[fragment] = container
        ids.push fragment
    if ids.length > 0
        youtube_fetch_snippets ids, (response)->
            for item in response.items
                container = info_instances[item.id]
                container.append $("<span class='video-info-channel'>#{item.snippet.channelTitle}</span>")
                container.append $("<span class='video-info-title'>#{item.snippet.title}</span>")


youtube_fetch_snippets = (ids, callback)->
    url_ids = encodeURIComponent ids.join(',')
    $.ajax
        cache: false
        dataType: 'json'
        url: "https://www.googleapis.com/youtube/v3/videos?part=snippet&id=#{url_ids}&key=#{API_KEY}"
        success: callback
