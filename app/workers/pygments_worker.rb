require 'net/http'
class PygmentsWorker
  include Sidekiq::Worker
  
  def perform(args)
    uri = URI('http://google.com')
    res = Net::HTTP.get(uri) # => String
    logger.info  res.body
#     logger.info  args
    
    # Push.new(args["members"], args["message"]).send_push
  end
end