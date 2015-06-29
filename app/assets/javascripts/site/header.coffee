$(document).on 'page:change', ->
    nav         = $ 'body > header nav'
    menuIcon    = $ 'body > header .icon-menu'
    
    menuIcon.click ->
        menuIcon.toggleClass 'nav-open'
        nav.toggleClass 'nav-open'

