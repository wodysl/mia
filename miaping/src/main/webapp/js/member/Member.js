$(document).ready(function() {
  $("input").mouseover(function(){
    $(this).css('cursor', 'pointer');
  });
});

function maxLengthChk(object){
  if (object.value.length > object.maxLength){
    object.value = object.value.slice(0, object.maxLength);
  }    
}

function IdInput(object)  {
  if (object.value.length > object.maxLength){
    object.value = object.value.slice(0, object.maxLength);
  }   
  object.value = object.value.replace(/[^A-Za-z]/ig, '')
}

function PwdInput(object)  {
  if (object.value.length > object.maxLength){
    object.value = object.value.slice(0, object.maxLength);
  }   
  object.value = object.value.replace(/[^A-Za-z]/ig, '')
}