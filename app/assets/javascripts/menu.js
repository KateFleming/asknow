$(document).ready(function(){
  var menu = $('.menu');
  var openButton = $('.open-menu');
  openButton.click(function(){
    menu.show();
  });
  $('.close-menu').click(function(){
    menu.hide();
  });
  
  $(this).click(function(event){
    // Don't hide menu when clicked on these items
    var whitelist = [menu, openButton, openButton.children()];
    var unlockOpen = true;
    
    for (var i=0; i < whitelist.length; i++) {
      if($(event.target).is(whitelist[i])){
        unlockOpen = false;
        return;
      }
    };
    
    if(unlockOpen){
      menu.hide();
    }
  });
});