class TimetablesController < ApplicationController
  respond_to :json

  def new
    @group = Group.find(params[:group_id])
    @timetable = @group.build_timetable
  end


  def create



    result = TimetableParser.new(params).parse

    group = Group.find_by_group_code(result['group_code'])

    timetable = Timetable.find_or_create_by(group_id: group.id)
         
    entries = result["entries"]

    members = result["members"]

    timetable.members = members

    message = 'http://idlecampus.com/groups/'+"RNHVQR"+'/timetable.json'

    timetable.message = message



    timetable.build_timetable_entries(entries)
      
    timetable.save

    render status: 200, nothing: true
 
  end

  



  def show
    
    group = params["group_id"]
    
    group = Group.find_by_group_code(group)



    teachers = group.teachers.pluck(:name)
    
    subjects = group.subjects.pluck(:name)

    rooms = group.teachers.pluck(:name)

   



    field_entries = []
  


    field_entry = {}
    field_entry["name"] = "room"
    field_entry["values"] = rooms.uniq
    field_entries << field_entry
  
 
    
    field_entry = {}
    field_entry["name"] = "teacher"
    field_entry["values"] = teachers.uniq
    field_entries << field_entry
  

  
   
    field_entry = {}
    field_entry["name"] = "subject"
    field_entry["values"] = subjects.uniq
    field_entries << field_entry
            
    
    timetable = group.timetable
    
    


  if timetable
    timetable_in_hash = timetable.timetable_in_hash
    render :json => timetable_in_hash
  else

    weekdays = []
    batches = []
    field_entries = []
    field_entry = {}
    field_entry["name"] = ""
    field_entry["values"] = []
    timetable_hash = {}
    entries_hash = {}

    entries_hash["group_code"] = group.group_code
    entries_hash["field_entries"] = field_entries.uniq
   
    entries_hash["weekdays"] = weekdays.uniq
    entries_hash["batches"] = batches.uniq.compact
    timetable_hash["timetable"] = entries_hash
    @timetable = ActiveSupport::JSON.encode(timetable_hash)
    render :json => @timetable
  end


   
    
    
  end

  private


  def timetable_params
    params.require(:timetable)
  end
end
