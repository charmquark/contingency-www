TOGGLE_TEMPLATE = $ '<span class="toggle"><span></span></span>'


$(document).on 'page:change', ->
    $('form').each ->
        form = $ this
        
        $('.radio-group', form).each ->
            init_radio_group form, $ this
        
        $('.check-group', form).each ->
            init_check_group form, $ this


init_check_group = (form, container)->
    $('> div', container).each ->
        control     = $ this
        cbox        = $ 'input[type=checkbox]', control
        elt         = cbox[0]
        label       = $ 'label', control
        toggle      = TOGGLE_TEMPLATE.clone()

        control.data 'cbox', cbox
        label.prepend toggle
        if elt.checked
            control.addClass 'checked'
            cbox.data 'initial', true
        else
            cbox.data 'initial', false

        label.click -> cbox.change()
        
        cbox.change -> control.toggleClass 'checked', elt.checked
    
    $('button[type=reset]', form).click ->
        $('> div', container).each ->
            control = $ this
            control.toggleClass 'checked', control.data('cbox').data('initial')


init_radio_group = (form, container)->
    container.data 'current', null
    $('> div', container).each ->
        control = $ this
        radio   = $ 'input[type=radio]', control
        label   = $ 'label', control
        toggle  = TOGGLE_TEMPLATE.clone()
        
        label.prepend toggle
        if radio.prop 'checked'
            container.data 'current', control
            control.addClass 'checked'
        
        label.click -> radio.click()
        
        radio.change -> select_radio container, control
    
    initial = container.data 'current'
    $('button[type=reset]', form).click -> select_radio container, initial


select_radio = (container, control)->
    current = container.data 'current'
    if current != control
        current.removeClass 'checked'
        container.data 'current', control
        control.addClass 'checked'

