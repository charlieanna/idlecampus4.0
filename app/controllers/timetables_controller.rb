#
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
    entries = result['entries']
    members = group.get_users
    timetable.members = members
    message = "http://idlecampus.com/groups/#{result['group_code']}/timetable.json"
    timetable.message = message
    timetable.build_timetable_entries(entries)
    timetable.save
    render status: 200, nothing: true
  end

  def show
    group = Group.find_by(group_code: params[:group_id])
    @timetable = group.timetable
    respond_with @timetable
  end

  private
  
  def timetable_params
    params.require(:timetable)
  end
end
