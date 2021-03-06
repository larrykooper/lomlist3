function sendFeedbackEmail() { 
  var form = $("#feedback-form");
  $.post('/feedback_messages', form.serialize(), function(data){    
    // tell the user email was sent
    $('#lightbox-response').html("Your feedback has been sent. Thanks!");
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
       }      
     }  
   });
   
   $('#feedback').click(function(e){
    $('#feedback-lightbox').dialog('open');
   
   });
   
});