class Push
  
  def send_push
   
      p params
      puser = params["users"]

      puser.slice!(puser.index('/'), puser.size)
      message = params["message"]
      devices = []
      user = User.find_by_jabber_id(puser)
      device = user.device_identifier
      devices << device

      timetable_hash = {}
      entries_hash = {}
      entries_hash["devices"] = devices
      entries_hash["message"] = message
      timetable_hash["push"] = entries_hash
      p timetable_hash
      @devices = ActiveSupport::JSON.encode(timetable_hash)

      p "CCCCCCCCCC"

      p request.fullpath
      p request.domain
      p request.base_url
      p request.original_fullpath

      puts "timetable push"

      uri = URI('http://developer.idlecampus.com/push/push1')
      p "UUUUUUUUUUURRRRRRRRRR"

      headers = {"Content-Type" => "application/json"}
      http = Net::HTTP.new(uri.host, uri.port)


      resp, dat = http.post(uri.path, timetable_hash.to_json, headers)
    

    end
  
end
