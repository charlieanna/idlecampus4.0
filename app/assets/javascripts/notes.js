
$(document).ready(function(){
  $('a').qtip({ // Grab some elements to apply the tooltip to
      content: {
          text: 'My common piece of text here'
      }
  })
 
  
  
  
 
  $('a, button').click(function() {
         $(this).toggleClass('active');
     });
		 
		 
   	
      // 
  
	$('#groupcode').tooltip()
  $('#groupname').tooltip()  
  $('#example').popover('hide')
  $("abbr.timeago").timeago();
  // $('#addtimetableentry #AddEntry').on('click', function (e) {
 //     entry = { 
 //         title:"ASdasd",
 //         start: new Date($('#apptStartTime').val()),
 //         end: new Date($('#apptEndTime').val()),
 //         allDay: ($('#apptAllDay').val() == "true"),
 //         teacher:"sdsadas",//$('#addtimetableentry #teacher option:selected').text(),
 //         room:"xcvxcv",//$('#addtimetableentry #room option:selected').text(),
 //         subject:"sdasda"//$('#addtimetableentry #subject option:selected').text()
 //      }
 //        entries.push(entry);
 //       $("#calendar").fullCalendar('renderEvent',
 //       {
 //         title:"ASdasd",
 //         start: new Date($('#apptStartTime').val()),
 //         end: new Date($('#apptEndTime').val()),
 //         allDay: ($('#apptAllDay').val() == "true"),
 //         teacher:$('#addtimetableentry #teacher option:selected').text(),
 //         room:$('#addtimetableentry #room option:selected').text(),
 //         subject:$('#addtimetableentry #subject option:selected').text()
 //       },
 //       true);
 //  })
  
  // $("#sendtimetable").click(function(){
//     var weekday=new Array(7);
//     weekday[0]="Sunday";
//     weekday[1]="Monday";
//     weekday[2]="Tuesday";
//     weekday[3]="Wednesday";
//     weekday[4]="Thursday";
//     weekday[5]="Friday";
//     weekday[6]="Saturday";
//     $( "#calendar .fc-header" ).first().remove();
//     $( "#calendar .fc-content" ).first().remove();
//     // setUpCalendar(false,entries);
//     a = $('#calendar').fullCalendar('clientEvents');
//     var entries = []
//     for(var i = 0;i<a.length;i++){
//       console.log(a)
//       entry = { to_hours:a[i].end.getHours(),
//           to_minutes:a[i].end.getMinutes(),
//           from_hours:a[i].start.getHours(),
//           from_minutes:a[i].start.getMinutes(),
//           teacher:a[i].teacher,
//           subject:a[i].subject,
//           room:a[i].room,
//          weekday:weekday[a[i].start.getDay()] }
//           entries.push(entry)
//     }
//     values = JSON.stringify(entries)
//     v = {
//           timetable:{
//             entries:JSON.stringify([[entries]])
//         }
//            
//   }
//     // console.log(JSON.stringify($('#calendar').fullCalendar('clientEvents') ));
//     $.post( window.location.pathname,v );
//     entries = a;
//     setUpCalendar(false,entries);
//   });
//   
})


