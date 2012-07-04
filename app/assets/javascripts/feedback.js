function sendFeedbackEmail() { 
  var form = $("#feedback-form");
  $.post('/feedback_messages', form.serialize(), function(data){    
    // tell the user email was sent

  });
}

$(document).ready(function() { 
  $('#feedback-lightbox').dialog({
     dialogClass: "feedbackdlg",
     autoOpen: false,
     width: 400,
     modal: true, 
     resizable: false,
     buttons: {
       "Send": function() {	
         sendFeedbackEmail();
         $(this).dialog("close");
       }      
     }  
   });
   
   $('#feedback').click(function(e){
    $('#feedback-lightbox').dialog('open'); 
   
   });
   
});