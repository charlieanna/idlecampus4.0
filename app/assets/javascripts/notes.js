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
		 
		 
   	var date = new Date();
   	var d = date.getDate();
   	var m = date.getMonth();
   	var y = date.getFullYear();
	
   	var calendar = $('#calendar').fullCalendar({
   
        defaultView: 'agendaWeek',
   		header: {
   			left:'',
   			center: '',
   			right: ''
   		},
   
   		selectable: true,
   		allDaySlot:false,
   		select: function(start, end, allDay) {
       
        endtime = $.fullCalendar.formatDate(end,'h:mm tt');
        starttime = $.fullCalendar.formatDate(start,'ddd, h:mm tt');
        var mywhen = starttime + ' - ' + endtime;
        $('#addtimetableentry #apptStartTime').val(start);
        $('#addtimetableentry #apptEndTime').val(end);
         $('#addtimetableentry #when').text(mywhen);
        a =  $.fullCalendar.formatDate(start, 'MM-dd-yyyy');
        var weekday=new Array(7);
        weekday[0]="Sunday";
        weekday[1]="Monday";
        weekday[2]="Tuesday";
        weekday[3]="Wednesday";
        weekday[4]="Thursday";
        weekday[5]="Friday";
        weekday[6]="Saturday";
        console.log(a);
         console.log(weekday[start.getDay()]);
         console.log(start.getHours());
          console.log(start.getMinutes());
          console.log(weekday[end.getDay()]);
          console.log(end.getHours());
           console.log(end.getMinutes());
         $('#addtimetableentry').modal('show');
         $("#start1").text(start.getDay());
         $("#end1").text(end);
   		  // var title = prompt('Event Title:');
 //      
 //         if (title) {
 //           calendar.fullCalendar('renderEvent',
 //             {
 //               title: title,
 //               start: start,
 //               end: end,
 //               teacher:"adsad",
 //               allDay: allDay
 //             },
 //             true // make the event "stick"
 //           );
 //         }
 //         calendar.fullCalendar('unselect');
   		},
   		editable: true,
   		events: [
		
		
	
   		
   		] , eventRender: function(event, element) {
         console.log(event.teacher);
         text = event.title+"</br>Teacher: "+event.teacher +"</br>Subject: "+event.subject+" </br>Room: "+event.room;
       $(element).html(text);
           // element.qtip({
    //            content: event.description
    //        });
       }
   	});
	
	$('#groupcode').tooltip()
  $('#groupname').tooltip()  
  $('#example').popover('hide')
  $("abbr.timeago").timeago();
  $('#addtimetableentry #AddEntry').on('click', function (e) {
   
       $("#calendar").fullCalendar('renderEvent',
       {
           title:$('#addtimetableentry #when').text(),
           start: new Date($('#apptStartTime').val()),
           end: new Date($('#apptEndTime').val()),
           allDay: ($('#apptAllDay').val() == "true"),
           teacher:$('#addtimetableentry #teacher option:selected').text(),
           room:$('#addtimetableentry #room option:selected').text(),
           subject:$('#addtimetableentry #subject option:selected').text()
       },
       true);
  })
  
  $("#sendtimetable").click(function(){
    a = $('#calendar').fullCalendar('clientEvents');
    entries = []
    for(var i = 0;i<a.length;i++){
      console.log(a)
      entry = { to_hours:a[i].end.getHours(),
          to_minutes:a[i].end.getMinutes(),
          from_hours:a[i].start.getHours(),
          from_minutes:a[i].start.getMinutes(),
          teacher:a[i].teacher,
          subject:a[i].subject,
          room:a[i].room }
          entries.push(entry)
    }
    values = JSON.stringify(entries)
    v = {
          timetable:{
            entries:JSON.stringify([[entries]])
        }
           
  }
    // console.log(JSON.stringify($('#calendar').fullCalendar('clientEvents') ));
    $.post( "/groups/" + "NQCQYX" + "/timetable",v );
  });
	
})
