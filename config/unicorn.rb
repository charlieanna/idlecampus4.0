worker_processes Integer(ENV["WEB_CONCURRENCY"] || 3)
timeout 15
preload_app true
before_fork do |server, worker|
   @sidekiq_pid ||= spawn("bundle exec sidekiq -q carrierwave,5 default")
   # spawn("bundle exec sidekiq -q push,5 default")
end

