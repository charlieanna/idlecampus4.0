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
    
    $.get( "/groups/" + "NQCQYX" + "/timetable",function(data){
      console.log(data);
      
      entries = [];
      var weekday=new Array(7);
      weekday[0]="Sunday";
      weekday[1]="Monday";
      weekday[2]="Tuesday";
      weekday[3]="Wednesday";
      weekday[4]="Thursday";
      weekday[5]="Friday";
      weekday[6]="Saturday";
	    for(var i = 0 ; i<data.timetable.entries.length;i++){
        obj = data.timetable.entries[i][0][0];
        var start =  new Date(y, m, d, obj.from_hours, obj.from_minutes);
        var end = new Date(y, m, d, obj.to_hours, obj.to_minutes);
        var currentDay = start.getDay();
        distance = weekday.indexOf(obj.weekday) - currentDay
        start.setDate(start.getDate() + distance);
        end.setDate(end.getDate() + distance);
        endtime = $.fullCalendar.formatDate(end,'h:mm tt');
        starttime = $.fullCalendar.formatDate(start,'ddd, h:mm tt');
        var mywhen = starttime + ' - ' + endtime;
        entry = { 
  			   	start: start,
  				  end: end,
            title:"",
            teacher:obj.teacher,
            subject:obj.subject,
            room:obj.room,
            allDay: false
          }
           entries.push(entry);
         }
   	var calendar = $('#calendar').fullCalendar({
      
           
     
   		events: entries,
    defaultView: 'agendaWeek',
  	header: {
		left:'',
		center: '',
		right: ''
	},
   		
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
   		 eventRender: function(event, element) {
        
          text = "Teacher: "+event.teacher +"</br>Subject: "+event.subject+" </br>Room: "+event.room;
           element.find('.fc-event-title').append("<br/>" + text);
           element.find('.fc-event-title').css("margin-top", "-18px");
           element.qtip({
                      content: text,
                      style: { classes: 'myCustomClass' }
                  });
//        $(element).html(text);
           // element.qtip({
    //            content: event.description
    //        });
       }
   	});
	 });
	$('#groupcode').tooltip()
  $('#groupname').tooltip()  
  $('#example').popover('hide')
  $("abbr.timeago").timeago();
  $('#addtimetableentry #AddEntry').on('click', function (e) {
   
       $("#calendar").fullCalendar('renderEvent',
       {
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
