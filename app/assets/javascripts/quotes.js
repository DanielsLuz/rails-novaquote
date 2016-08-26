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

$(document).ready(function(){

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
