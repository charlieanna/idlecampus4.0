class Push
  
  def initialize(devices,message)
    @message = message
    @devices = devices
  end
    def push
      create_push
     
    end
  
  
    def create_push
      timetable_hash = {}
      entries_hash = {}
      entries_hash["devices"] = @devices
      entries_hash["message"] = @message
      timetable_hash["push"] = entries_hash
      send_push timetable_push
    end
    
    def send_push(hash)
      uri = URI('http://developer.idlecampus.com/push/push1')
    

      headers = { "Content-Type" => "application/json"}
                    http = Net::HTTP.new(uri.host, uri.port)


                               resp, dat = http.post(uri.path, hash.to_json, headers)
      
    end
end
