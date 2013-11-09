class PygmentsWorker
  include Sidekiq::Worker
  
  def perform(args)
    puts "AAAAASDADASDADAD"
    puts args
    
    Push.new(args["members"], args["message"]).send_push
  end
end