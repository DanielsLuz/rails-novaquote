var diffObjects = function(newArray, oldArray){
  var difference = [];
  $(newArray).each(function(index, el){
    if(!oldArray.some(function(e){e.id == el.id})){
      difference.push(el)
    }
  })
  return difference;
}
