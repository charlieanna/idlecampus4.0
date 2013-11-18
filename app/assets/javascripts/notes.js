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
	
	
	
})
