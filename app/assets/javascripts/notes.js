// jQuery ->
//   $('#note_file').fileupload
//     dataType: "script"
//     add: (e, data) ->
//       console.log(data)
//       data.context = $(tmpl("template-upload", data.files[0]))
//       console.log(data.context)
//       $('#note_file').append(data.context)
//       data.submit()
//     progress: (e, data) ->
//       if data.context
//         progress = parseInt(data.loaded / data.total * 100, 10)
//         console.log(progress)
//         data.context.find('.bar').css('width', progress + '%')
$(document).ready(function(){
  
 
  $('a, button').click(function() {
         $(this).toggleClass('active');
     });
		 
		 
		 // $("#note_file_button").click(function(){
 // 			 var $input, currentgroup, formData;
 // 
 // 			 $("#message").hide();
 // 
 // 			
 // 
 // 			 $("#note_file_button").text("Sending...");
 // 
 // 			 formData = new FormData();
 // 
 // 			 $input = $("#note_file");
 // 
 // 			 formData.append("note[file]", $input[0].files[0]);
 // 
 // 			 formData.append("note_text", $("#note_text").val());
 // 
 // 			 formData.append("group", $("#note_group_code").val());
 // 
 // 			 $.ajax({
 // 			   url: "/notes",
 // 			   data: formData,
 // 			   cache: false,
 // 			   contentType: false,
 // 			   processData: false,
 // 			   method: 'POST'
 // 			 }).done(function() {
 // 			   $("#message").show();
 // 			   $("a, button").toggleClass("active");
 // 			   return $("#note_file_button").text("Send");
 // 			 });
 // 
 // 			 console.log("ajax");
 // 		 })
	$('#groupcode').tooltip()
  $('#groupname').tooltip()  
  $('#example').popover('hide')
  $("abbr.timeago").timeago();
	
	
})
