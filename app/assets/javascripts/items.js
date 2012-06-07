$(document).ready(function() {
	$('.tag').click(function(event) {
    var oldtagslist = $('#tag_list').val();
    var newtagslist = oldtagslist + ' ' + $(event.target).text().trim();
    $('#tag_list').val(newtagslist);
  });

  $('#jq-dialog').dialog({
      autoOpen: false,
      width: 400,
      modal: true,
      resizable: false,
      buttons: {
        "OK": function() {
          document.deleteItem.submit();
        },
        "Cancel": function() {
          $(this).dialog("close");
        }
      }
    });           
  
  	$('form#deleteItem').submit(function(e){
      e.preventDefault();     
      var nbrtodelete = $("input#nbrtodelete").val();
      $("span#dialog-number strong").html(nbrtodelete);
      var itemText = $("#text-"+nbrtodelete).html();
      $("div#dialog-text").html(itemText.substring(0,350));
      $('#jq-dialog').dialog('open');
    });
 	
});