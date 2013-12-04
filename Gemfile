source 'https://rubygems.org'
ruby '2.0.0'
#ruby-gemset=railstutorial_rails_4_0
 gem 'rake', '10.0.4'
 gem 'rails', '4.0.1'
gem 'bootstrap-sass', '2.3.2.0'
gem 'bcrypt-ruby'

gem 'sidekiq'
gem 'unf' 
gem 'debugger', group: [:development, :test]
group :development, :test do
  gem 'sqlite3'
  gem 'rspec-rails', '2.13.1'
  gem 'guard-rspec', '2.5.0'
   gem 'spork-rails', '4.0.0'
  gem 'guard-spork', '1.5.0'
  gem 'childprocess', '0.3.6'
  gem "launchy", "~> 2.3.0"
  
end 
gem "cancan"  
gem "bullet", :group => "development"
gem 'jasmine', :group => [:development, :test]
gem 'sinatra', require: false
gem 'slim'
 gem "acts_as_follower"
 gem 'carrierwave_backgrounder'
group :test do
  gem 'factory_girl_rails', '4.2.1'
 
 gem "faker", "~> 1.2.0"

   gem 'cucumber-rails', '1.4.0', :require => false
  gem 'database_cleaner', github: 'bmabey/database_cleaner'
 
end
gem "devise", "~> 3.2.0"
group :development do
  gem 'capistrano'
end
group :test do
  gem 'capybara', "~> 2.1.0"
   gem "poltergeist", "~> 1.4.1"
gem 'mail_form'
gem 'shoulda-matchers'
end
gem 'turbolinks'
gem 'carrierwave_direct'
gem "fog"
gem 'unicorn'
gem 'carrierwave'
gem 'daemons'
gem "xmpp4r", "~> 0.5.5"
gem 'delayed_job_active_record'
gem "haml"
gem 'newrelic_rpm'
gem 'gon'
gem 'sass-rails', '4.0.1'
gem 'uglifier', '2.1.1'
gem 'coffee-rails', '4.0.1'
gem 'paperclip'
gem 'aws-sdk'
gem "rmagick"
gem 'jquery-rails', '3.0.4'
gem 'jquery-ui-rails'
gem 'jquery-fileupload-rails'
gem 'jbuilder', '1.0.2'
gem 'rest-client'
gem 'hpricot'
gem 'angularjs-rails'
gem 'foreman'
gem 'remotipart', '~> 1.2'
gem "active_model_serializers"
group :doc do
  gem 'sdoc', '0.3.20', require: false
end
# 
group :production do
  gem 'pg', '0.15.1'
  gem 'rails_12factor', '0.0.2'
end