
$(document).ready(function(){
  
  $("#edittimetable").click(function(){
    console.log("working");
    $( "#calendar .fc-header" ).first().remove();
     $( "#calendar .fc-content" ).first().remove();
    setUpCalendar(true,entries);
  })
  $('a, button').click(function() {
         $(this).toggleClass('active');
     });
		 
		 
   	
      //   
  entries = getEntries();
  
	$('#groupcode').tooltip()
  $('#groupname').tooltip()  
  $('#example').popover('hide')
  $("abbr.timeago").timeago();
  $('#addtimetableentry #AddEntry').on('click', function (e) {
     entry = { 
         title:"ASdasd",
         start: new Date($('#apptStartTime').val()),
         end: new Date($('#apptEndTime').val()),
         allDay: ($('#apptAllDay').val() == "true"),
         teacher:"sdsadas",//$('#addtimetableentry #teacher option:selected').text(),
         room:"xcvxcv",//$('#addtimetableentry #room option:selected').text(),
         subject:"sdasda"//$('#addtimetableentry #subject option:selected').text()
      }
        entries.push(entry);
       $("#calendar").fullCalendar('renderEvent',
       {
         title:"ASdasd",
         start: new Date($('#apptStartTime').val()),
         end: new Date($('#apptEndTime').val()),
         allDay: ($('#apptAllDay').val() == "true"),
         teacher:"sdsadas",//$('#addtimetableentry #teacher option:selected').text(),
         room:"xcvxcv",//$('#addtimetableentry #room option:selected').text(),
         subject:"sdasda"//$('#addtimetableentry #subject option:selected').text()
       },
       true);
  })
  
  $("#sendtimetable").click(function(){
    $( "#calendar .fc-header" ).first().remove();
    $( "#calendar .fc-content" ).first().remove();
    // setUpCalendar(false,entries);
    a = $('#calendar').fullCalendar('clientEvents');
    var entries = []
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
    $.post( window.location.pathname,v );
    entries = a;
    setUpCalendar(false,entries);
  });
	
})

function getEntries(){
 	var date = new Date();
 	var d = date.getDate();
 	var m = date.getMonth();
 	var y = date.getFullYear();
 
  $.get( window.location.pathname,function(data){
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
       setUpCalendar(false,entries);
     });
     
}

function setUpCalendar(editable,entries) { 
   	var calendar = $('#calendar').fullCalendar({
      
           
     
         events: entries,
    defaultView: 'agendaWeek',
  	header: {
		left:'',
		center: '',
		right: ''
	},
  selectable:editable,
  editable: editable,
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
   		 
         calendar.fullCalendar('unselect');
   		},
   		
   		 eventRender: function(event, element) {
        
          text = "Teacher: "+event.teacher +"</br>Subject: "+event.subject+" </br>Room: "+event.room;
           element.find('.fc-event-title').append("<br/>" + text);
           element.find('.fc-event-title').css("margin-top", "-18px");
           element.qtip({
                      content: text,
                      style: { classes: 'myCustomClass' }
                  });

       }
      });
 }
