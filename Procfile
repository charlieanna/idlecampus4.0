web: bundle exec unicorn -p $PORT -c ./config/unicorn.rb

worker:  bundle exec rake jobs:work

before_fork do |server, worker|
   @sidekiq_pid ||= spawn("bundle exec sidekiq -c 2")
end
