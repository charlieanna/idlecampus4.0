source 'https://rubygems.org'
ruby '2.0.0'
#ruby-gemset=railstutorial_rails_4_0

gem 'rails', '4.0.0'
gem 'bootstrap-sass', '2.3.2.0'
gem 'bcrypt-ruby', '3.0.1'
gem 'sidekiq'
gem 'debugger', group: [:development, :test]
group :development, :test do
  gem 'sqlite3'
  gem 'rspec-rails', '2.13.1'
  gem 'guard-rspec', '2.5.0'
   gem 'spork-rails', '4.0.0'
  gem 'guard-spork', '1.5.0'
  gem 'childprocess', '0.3.6'

end
gem 'rb-readline'
gem "bullet", :group => "development"
gem 'jasmine', :group => [:development, :test]
group :test do
	gem 'factory_girl_rails', '4.2.1'
  gem 'selenium-webdriver', '2.35.1'
  gem 'capybara', '2.1.0'
   gem 'cucumber-rails', '1.4.0', :require => false
  gem 'database_cleaner', github: 'bmabey/database_cleaner'
end
group :development do
  gem 'capistrano'
end
gem "haml"
gem 'newrelic_rpm'
gem 'gon'
gem 'sass-rails', '4.0.0'
gem 'uglifier', '2.1.1'
gem 'coffee-rails', '4.0.0'
gem 'jquery-rails', '3.0.4'
gem 'jquery-ui-rails'
gem 'jquery-fileupload-rails'
# gem 'turbolinks', '1.1.1'
gem 'jbuilder', '1.0.2'
gem 'rest-client'
gem 'hpricot'
gem 'angularjs-rails'
group :doc do
  gem 'sdoc', '0.3.20', require: false
end

group :production do
  
  gem 'rails_12factor', '0.0.2'
end
gem 'pg'