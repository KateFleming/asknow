$(document).ready(function(){
  // On focus actions
  var maxChars = 100;
  var container = $('.feed-question-new');
  var field = container.find('.feed-question-field');
  var submit = container.find(".feed-question-submit");
  var counter = container.find('.character-counter');
  var footer = container.find('footer');
  
  // Set counter
  counter.text(maxChars);
  
  // Show and hide footer on focus
  field.focus(function(){
    field.addClass("active");
    footer.show();
  }).blur(function(){
    if(!$(this).val().length){
      field.removeClass("active");
      footer.hide();
    }
  });
  
  // Show charaters left
  field.keyup(function(){
    var size = $(this).val().length
    counter.text(maxChars - size);
    if(size > maxChars){
      $(this).addClass("over-limit");
      submit.prop("disabled", true);
    } else {
      $(this).removeClass("over-limit");
      submit.prop("disabled", false);
    }
  });
});