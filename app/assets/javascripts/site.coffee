body = header = main = footer = null


enable_header_menu = ()->
	nav = $ 'nav', header
	menuIcon = $ '.icon-menu', header

	menuIcon.click ->
		menuIcon.toggleClass 'nav-open'
		nav.toggleClass 'nav-open'


fetch_page_elements = ()->
	body = $ 'body'
	header = $ '> header', body
	main = $ '> main', body
	footer = $ '> footer', body


set_backgrounds = ()->
	$('[data-background]').each ->
		elt = $ this
		bg = elt.data 'background'
		elt.css
			'background-image': "url('#{bg}')"


$(document).on 'page:change', ->
	fetch_page_elements()
	set_backgrounds()
	enable_header_menu()

