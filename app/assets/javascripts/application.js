//= require modernizr/modernizr-dev.min
//= require_self
//= require jquery
//= require jquery_ujs
//= require metaquery/metaquery.min
//= require_tree .
//= require turbolinks

Modernizr.load([{
    test: ( !! window.matchMedia ),
    nope: ["/javascripts/matchMedia.js"]
}]);
