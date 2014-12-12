$(document).ready(function(){
  $('.auto-highlight').mouseup(function(event){
    event.preventDefault();
  }).focus(function(){
    $(this).select();
  });
});