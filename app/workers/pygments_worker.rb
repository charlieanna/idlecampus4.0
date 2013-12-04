#
class PygmentsWorker
  include Sidekiq::Worker
  sidekiq_options :queue => :carrierwave, :retry => false, :backtrace => true
  def perform(args)
    Push.new(args["from"],args['members'], args['message'], args['app']).send_push
  end
end
