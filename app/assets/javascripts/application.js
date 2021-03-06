//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require jquery-fileupload/basic
//= require jquery-fileupload/jquery.fileupload-process
//= require jquery-fileupload/jquery.fileupload-validate
//= require twitter/typeahead
//= require local_time
//= require jquery.Jcrop
//= require pagedown_bootstrap
//= require highlight.pack.js
//= require exif
//= require moment
//= require bootstrap-datetimepicker

//= require_tree .

$(document).ready(ready)

function ready() {

  $('#starttimepicker').datetimepicker({
    format: 'LT'
  });

  $('#datepicker').datetimepicker({
    format: 'MMM Do YYYY'
  });

  userEdit();
  
  if($('#category_select').length){ // question form has the category_select input
    set_question_tag_autocomplete();
  };

  if($('#group_tag_input').length){ //group tag has the group_tag_input field
    set_group_tag_autocomplete();
  };

  $('[data-toggle="tooltip"]').tooltip()

  $('textarea.wmd-input').each(function(i, input) {
    var attr, converter, editor;
    attr = $(input).attr('id').split('wmd-input')[1];
    converter = new Markdown.Converter();
    Markdown.Extra.init(converter, {highlighter: "highlight"});
    editor = new Markdown.Editor(converter, attr);
    return editor.run();
  });

  $('.markdown-output').each(function(i, input) {
    var converter = Markdown.getSanitizingConverter();
    Markdown.Extra.init(converter, {highlighter: "highlight"});
    $(input).html(converter.makeHtml($(input).text()));
  });

  $('pre code').each(function(i, block) {
    hljs.highlightBlock(block);
  });

}

function getOrientation(exifOrientation) {
  // gets orientation tag from image EXIF metadata
  var orientation = parseInt(EXIF.getTag(exifOrientation, 'Orientation'));
  switch(orientation) {
    case 2:
      return 'flip';
    case 3:
      return 'rotate-180';
    case 4:
      return 'flip-and-rotate-180';
    case 5:
      return 'flip-and-rotate-270';
    case 6:
      return 'rotate-90';
    case 7:
      return 'flip-and-rotate-90';
    case 8:
      return 'rotate-270';
  }
}
