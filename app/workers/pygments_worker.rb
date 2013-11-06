class PygmentsWorker
  include Sidekiq::Worker
  
  def perform(timetable_id)
    
    timetable = Timetable.find(timetable_id)
    Push.new(timetable.members, timetable.message).delay.send_push
  end
end