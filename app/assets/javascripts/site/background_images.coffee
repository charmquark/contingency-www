$(document).on 'page:change', ->
    body = $('body')
    bg = body.data 'background'
    if bg?
        body.css 'background-image': "url('#{bg}')"
