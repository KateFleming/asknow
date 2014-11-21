$(document).ready(function(){
  var menu = $('.menu');
  var openButton = $('.open-menu');
  openButton.click(function(){
    menu.css({
      right: 0
    });
    $(this).hide();
  });
  $('.close-menu').click(function(){
    menu.css({
      right: "-300px"
    });
    openButton.show();
  });
});