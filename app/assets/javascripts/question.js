ask.question = function(){
  // Keep a bunch of tags
  var tags = [];
  function publicTags(){
    return tags;
  }
  
  function publicParseTags(self){
    var entry = self.val();
    var PATTERN = /#(?:[^?#.!\s]+)/ig;
    
    var list = $('<ul/>');
    tags = entry.match(PATTERN);
    
    // Loop through each tag and put it into a list
    if (tags){
      for (var i=0; i < tags.length; i++) {
        var tag = tags[i].replace("#", "").toLowerCase();
        tags[i] = tag;
        list.append($('<li/>').text(tag));
      };
    } 
      
    return list;
    
  }
  return {
    tags: publicTags,
    parseTags: publicParseTags
  }
}();
$(document).ready(function(){
  // On focus actions
  var maxChars = 125;
  var form = $('.feed-question-new .new_question');
  var field = form.find('.feed-question-field');
  var submit = form.find(".feed-question-submit");
  var counter = form.find('.character-counter');
  var tagBin = form.find('.tag-bin');
  var keywords = form.find('#question_keywords');
  var footer = form.find('footer');
  
  // Set counter
  counter.text(maxChars);
  
  // Show and hide footer on focus
  field.focus(function(){
    field.addClass("active").attr("placeholder", "Add tags like #seattle #outdoors.");
    footer.show();
  }).blur(function(){
    if(!$(this).val().length){
      field.removeClass("active").attr("placeholder", field.attr("title"));
      footer.hide();
    }
  });
  
  field.keyup(function(){
    
    // Pull out the tags
    tagBin.html(ask.question.parseTags($(this)));
    
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
  
  // When the form is submited, add keywords to field
  form.submit(function(){
    $('#question_keywords').val(ask.question.tags().join(","))
  });
});