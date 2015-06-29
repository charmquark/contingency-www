//= require modernizr/modernizr-dev.min
//= require jquery
//= require jquery_ujs
//= require_self
//= require metaquery/metaquery.min
//= require_tree .
//= require turbolinks


Modernizr.load([{
    test: ( !! window.matchMedia ),
    nope: ["javascripts/matchMedia.js"]
}]);


$(document).on('page:change', function() {
    init_header_menu();
    init_forms();
});


function init_header_menu() {
    var nav = $('body > header nav');
    var menuIcon = $('body > header .icon-menu');
    
    menuIcon.click(function() {
        menuIcon.toggleClass('nav-open');
        nav.toggleClass('nav-open');
    });
}


function init_forms() {
    $('form').each(function() {
        var form = $(this);
        $('.radio-group', form).each(init_radio_group);
    });
}


function init_radio_group() {
    var container = $(this);
    var toggleTemplate = $('<span class="toggle"><span></span></span>');

    container.data('current', null);
    $('> div', container).each(function() {
        var control = $(this);
        var radio = $('input', control);
        var toggle = toggleTemplate.clone();
        
        control.prepend(toggle);
        if (radio.prop('checked')) {
            container.data('current', control);
            control.addClass('checked');
        }
        
        $('label', control).add(toggle).click(function() { radio.click(); });
        
        radio.change(function() {
            var prev = container.data('current');
            if (prev !== control) {
                prev.removeClass('checked');
                container.data('current', control);
            }
            control.addClass('checked');
        });
    });
}
