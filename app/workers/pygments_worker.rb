class PygmentsWorker
  include Sidekiq::Worker
  
  def perform(self)
    Push.new(self.members, self.message).delay.send_push
  end
end