class TimetableParser
	def initialize(params)
		@params = params
	end

	def parse

		result = Hash.new
		
		group = @params['timetable']["group"]["group_code"]

		result["group_code"] = group

		
		entries = ActiveSupport::JSON.decode(@params['timetable']["entries"])

		result['entries'] = entries

		members = @params['timetable']["members"]

		result['members'] = members

		result

   
	end
end