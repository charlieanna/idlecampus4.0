#
class TimetableParser
  def initialize(params)
    @params = params
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
