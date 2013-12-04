#
class TimetableParser
  def initialize(params)
    @params = params
    # result = parse
#     group = Group.find_by_group_code(result['group_code'])
#     @timetable = Timetable.find_or_create_by(group_id: group.id)
#     @entries = result['entries']
#     members = group.get_users
#     @timetable.members = members
#     message = "http://idlecampus.com/groups/#{result['group_code']}/timetable.json"
#     @timetable.message = message
#    
#     
  end

  def parse
    result = {}
    group = @params['group_id']
    result['group_code'] = group
    entries = ActiveSupport::JSON.decode(@params['timetable']['entries'])
    result['entries'] = entries
    members = @params['timetable']['members']
    result['members'] = members
    return result
  end
end
  