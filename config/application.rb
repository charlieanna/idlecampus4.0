require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module IdleCampus
  class Application < Rails::Application
      config.assets.compress = true
 config.assets.js_compressor  = :uglifier
  config.assets.css_compressor = :sass
  end
end
