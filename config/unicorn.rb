worker_processes Integer(ENV["WEB_CONCURRENCY"] || 5)
timeout 15
preload_app true

before_fork do |server, worker|
 @sidekiq_pid ||= spawn("bundle exec sidekiq -c 2")
end

after_fork do |server, worker|
  Signal.trap 'TERM' do
    puts 'Unicorn worker intercepting TERM and doing nothing. Wait for master to send QUIT'
  end

  defined?(ActiveRecord::Base) and ActiveRecord::Base.establish_connection

  Sidekiq.configure_client do |config|
    config.redis = { size: 1, namespace: 'sidekiq' }
  end
end