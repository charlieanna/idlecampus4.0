IdleCampus::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false
  config.assets.js_compressor  = :uglifier
  config.assets.css_compressor = :sass
  # Do not eager load code on boot.
  config.eager_load = false
  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = true

  # Change mail delvery to either :smtp, :sendmail, :file, :test
  config.action_mailer.delivery_method = :letter_opener
  config.action_mailer.smtp_settings = {
    address: "smtp.gmail.com",
    port: 587,
    domain: "gmail.com",
    authentication: "plain",
    enable_starttls_auto: true,
    user_name: "ankothari",
    password: "akpk2972@"
  }

  # Specify what domain to use for mailer URLs
  config.action_mailer.default_url_options = {host: "localhost:3000"}
  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false
  
  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log
  config.assets.compress = true
  # Raise an error on page load if there are pending migrations
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true
  
  config.after_initialize do
    Bullet.enable = true
    # Bullet.alert = true
    Bullet.bullet_logger = true
    Bullet.console = true
  #  Bullet.growl = true
    Bullet.rails_logger = true
   
  end
end

IdleCampus::Application.config.middleware.use ExceptionNotification::Rack,
  :email => {
    :email_prefix => "[Whatever] ",
    :sender_address => %{"notifier" <notifier@example.com>},
    :exception_recipients => %w{ankothari@gmail.com}
  }
