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
});


function init_header_menu() {
    var nav = $('body > header nav');
    var menuIcon = $('body > header .icon-menu');
    
    menuIcon.click(function() {
        menuIcon.toggleClass('nav-open');
        nav.toggleClass('nav-open');
    });
}