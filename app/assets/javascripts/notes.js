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
	$("#note_file_button").click(function(){
		$("#message").hide();
		$('#note_file_button').text("Sending...");
		var formData = new FormData(),
		    $input = $('#note_file');
    
		formData.append('note[file]', $input[0].files[0]);
		formData.append('note_text', $("#note_text").val());
 
		$.ajax({
		  url: '/notes',
		  data: formData,
		  cache: false,
		  contentType: false,
		  processData: false,
		  type: 'POST'
		}).done(function() {
			$("#message").show();
$('a, button').toggleClass('active');
$('#note_file_button').text("Send");
});
	});
	
	
})
