var diffObjects = function(newArray, oldArray){
  var difference = [];
  $(newArray).each(function(index, new_elem){
    // if(oldArray.filter(function(e){e.id == el.id}).length == 0){
    if(!containsObject(new_elem, oldArray)){
      difference.push(new_elem)
    }
  })
  return difference;
}

function containsObject(obj, oldArray) {
  contains = 0;
  $(oldArray).each(function(index, elem){
    if (elem.id == obj.id) {
      contains = 1;
    }
  })
  return contains;
}
