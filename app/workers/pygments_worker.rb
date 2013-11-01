
class PygmentsWorker
  include Sidekiq::Worker
  
  def perform(timetable)
   Push.new(timetable.members, timetable.message).delay.send_push
  end
end