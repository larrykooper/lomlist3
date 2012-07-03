$(document).ready(function() { 
  $('#feedback-lightbox').dialog({
     dialogClass: "feedbackdlg",
     autoOpen: false,
     width: 400,
     modal: true, 
     resizable: false,
     buttons: {
       "Send": function() {	
         $(this).dialog("close");
       }      
     }  
   });
   
   $('#feedback').click(function(e){
    $('#feedback-lightbox').dialog('open'); 
   
   });
   
});