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
    var order_btn = $('#order_btn')[0];
    // strip parameters
    var href_new =  order_btn.href.substr(0, order_btn.href.indexOf('?') + 1);
    
    // add modifed parameter so controller will update
    href_new += "no_change=false";
    
    var articles = $('#sortable')[0];
    for (var i = 0; i < articles.children.length; i++) {
        href_new += "&new_order[" + i + "]=" + articles.children[i].id;
    }
    
    order_btn.href = href_new;
};

$(document).on('turbolinks:load', function() {
    $("#sortable").sortable({
        helper: fixHelperModified,
        stop: updateIndex,
        update: updateLink
    }).disableSelection();
});

$( document ).ready(function() {
    
    $('#confirm-delete').on('show.bs.modal', function(e) {
        var url = $(e.relatedTarget).data('href');
        var message = $(e.relatedTarget).data('message');
        
        $('#delete-message').text(message);
        
        $('#confirm-delete').on('click', '.btn-ok', function(e) {
            $('#my-loader').removeClass('hide');
            
            $.ajax({
                url: url,
                type: 'DELETE',
                success: function(response) {
                    console.log('Delete success');
                    $('#my-loader').addClass('hide');
                },
                error: function(response) {
                    console.log('Error on delete');
                    $('#delete-message').text('An error occurred when deleting, try it again later');
                    $('#my-loader').addClass('hide');
                }
            });
            
        });
    });
});


