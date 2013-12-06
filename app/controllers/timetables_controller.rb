#
class TimetablesController < ApplicationController
  respond_to :json,:html
  before_action :signed_in_user, only: [:create, :destroy,:show]
  def new
    @group = Group.find(params[:group_id])
    @timetable = @group.build_timetable
  end
  
	
 

  def create
	
    
    result = TimetableParser.new(params).parse
    group = Group.find_by_group_code(result['group_code'])
    timetable = Timetable.find_or_create_by(group_id: group.id)
    entries = result['entries']
    members = group.get_users
    timetable.members = params['timetable']['members']
    message = "http://idlecampus.com/groups/#{result['group_code']}/timetable.json"
    timetable.message = message
    timetable.build_timetable_entries(entries)
    timetable.save
    render status: 200, nothing: true
  end

  def show
    @group = Group.find_by(group_code:params[:group_id])
    @timetable = @group.timetable
    gon.calendar = true
    if @timetable
      respond_with @timetable
    else
      weekdays = []
	    batches = []
      field_entries = []

      timetable_hash = {}
      entries_hash = {}

      entries_hash["group_code"] = @group.group_code
      entries_hash["field_entries"] = field_entries.uniq
  
      entries_hash["weekdays"] = weekdays.uniq
      entries_hash["batches"] = batches.uniq.compact
      timetable_hash["timetable"] = entries_hash
      @timetable = ActiveSupport::JSON.encode(timetable_hash)
 
      respond_with timetable_hash
      
    end
   
  end

  private
  
  def timetable_params
    params.require(:timetable)
  end
end
