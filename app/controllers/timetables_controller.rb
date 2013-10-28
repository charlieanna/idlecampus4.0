class TimetablesController < ApplicationController
  respond_to :json

  def new
    @group = Group.find(params[:group_id])
    @timetable = @group.build_timetable
  end


  def create
    puts params
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
     
    timetable_in_hash = TimetableBuilder.new(group).build
    
    render :json => timetable_in_hash

 end

  private


  def timetable_params
    params.require(:timetable)
  end
end
