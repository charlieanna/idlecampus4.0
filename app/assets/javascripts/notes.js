
$(document).ready(function(){
  $('a, button').click(function() {
         $(this).toggleClass('active');
     });
	$('#groupcode').tooltip()
  $('#groupname').tooltip()  
  $('#example').popover('hide')
  $("abbr.timeago").timeago();
  
  $("#start").click(function(){
    $('body').chardinJs('start')
  })
   
})


