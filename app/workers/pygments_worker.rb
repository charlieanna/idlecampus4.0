class PygmentsWorker
  include Sidekiq::Worker
  
  def perform(args)
    logger.info  "AAAAASDADASDADAD"
    logger.info  args
    
    Push.new(args["members"], args["message"]).send_push
  end
end