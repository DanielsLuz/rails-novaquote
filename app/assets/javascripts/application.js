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
//= require bootstrap-sprockets
//= require jquery_ujs
//= require turbolinks
//= require_tree .
$(document).ready(function(){

  var diffObjects = function(newArray, oldArray){
    var difference = [];
    $(newArray).each(function(index, el){
      if(!oldArray.some(function(e) e.id == el.id)){
        difference.push(el)
      }
    })
    return difference;
  }

  var createQuoteNode = function(quote) {
    var aDiv = $('<div/>', {
      'class':'content col-sm-6'
    })
    var text = $('<p>', {
      'class':'medium-font',
      'text': quote.text
    })
    var author = $('<p>', {
      'class':'text-right author',
      'text': '- ' + quote.user_name
    })
    $(aDiv).append(text).append(author);
    return aDiv
  }

  var renderQuotes = function(quotesArray) {
    window.quotesArray = quotesArray;
    $('.container').children().slice(10 - quotesArray.length).remove();
    for(quote of quotesArray.reverse()){
      node = createQuoteNode(quote);
      $('.container').prepend($(node).fadeIn('slow'));
    }
  }

  var latestQuotes = [];

  var getLatestQuotes = function(){
    $.ajax({
      url: '/quotes/most_recent',
      type: 'GET',
      success: function(resp){
        var diff = diffObjects(resp, latestQuotes);
        latestQuotes = resp;
        if(diff.length){
          renderQuotes(diff);
        }
      },
      error: function(resp){
        console.log(resp);
      }
    })
  }

  setInterval(getLatestQuotes, 5000);
})
