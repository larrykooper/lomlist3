$(document).ready(function() {
	$('.tag').click(function(event) {
    var oldtagslist = $('#tag_list').val();
    var newtagslist = oldtagslist + ' ' + $(event.target).text().trim();
    $('#tag_list').val(newtagslist);
  });
	
});

