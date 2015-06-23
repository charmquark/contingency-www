//= require modernizr/modernizr-dev.min
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_self
//= require metaquery/metaquery.min
//= require_tree .


Modernizr.load([{
    test: ( !! window.matchMedia ),
    nope: ["javascripts/matchMedia.js"]
}]);


$(function() {
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