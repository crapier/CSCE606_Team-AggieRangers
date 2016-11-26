// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .
//= require bootstrap.min
//= require jquery-ui.min


// Helpers from https://stackoverflow.com/questions/2072848/reorder-html-table-rows-using-drag-and-drop

var fixHelperModified = function(e, tr) {
    var $originals = tr.children();
    var $helper = tr.clone();
    $helper.children().each(function(index) {
        $(this).width($originals.eq(index).width())
    });
    return $helper;
};

updateIndex = function(e, ui) {
    $('td.index', ui.item.parent()).each(function (i) {
        $(this).html(i + 1);
    });
};

updateLink = function(e, ui) {
    // strip parameters
    var href_new =  window.location.href + "/reorder?"
    
    // add modifed parameter so controller will update
    href_new += "no_change=false";
    
    var articles = $('#sortable')[0];
    for (var i = 0; i < articles.children.length; i++) {
        href_new += "&new_order[" + i + "]=" + articles.children[i].id;
    }
    
    Turbolinks.visit(href_new)
};

$(document).on('turbolinks:load', function() {
    $("#sortable").sortable({
        helper: fixHelperModified,
        stop: updateIndex,
        update: updateLink
    }).disableSelection();
});

