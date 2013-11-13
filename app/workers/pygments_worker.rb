class PygmentsWorker
  include Sidekiq::Worker
  
  def perform(args)
    # logger.info  "AAAAASDADASDADAD"
#     logger.info  args
    
    Push.new(args["members"], args["message"],args["app"]).send_push
  end
end