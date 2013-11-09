class Push
  include Sidekiq::Worker
    attr_reader :members,:message
  def initialize(members,message)
    @message = message
    @members = members
    logger.info "MESSAGE"
    logger.info @message
    logger.info "MEMBERS"
    logger.info @members
  end
  
  def devices
    User.get_devices(@members)
   
  end
  

    
  
  
    def create_push
      
      timetable_hash = {}
      entries_hash = {}
      
      entries_hash["devices"] = devices
      logger.info entries_hash
      entries_hash["message"] = message
      logger.info entries_hash
      timetable_hash["push"] = entries_hash
      logger.info timetable_hash
      return timetable_hash
    end
    
    def send_push

      hash = create_push
      
      logger.info "HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH"
      
      logger.info hash

      uri = URI('http://developer.idlecampus.com/push/push1')
    

      headers = { "Content-Type" => "application/json"}
                    http = Net::HTTP.new(uri.host, uri.port)


                               resp, dat = http.post(uri.path, hash.to_json, headers)

    return resp.code
      
    end
end
