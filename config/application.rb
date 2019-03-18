require_relative 'boot'
require 'rails'
%w[action_controller
   action_mailer
   active_resource
   rails/test_unit].each do |framework|
  begin
    require "#{framework}/railtie"
  rescue LoadError
  end
end
require 'active_storage/engine'
require 'sprockets/railtie'

# require 'rails/all'
# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.

Bundler.require(*Rails.groups)

module LibraryExercise
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2
    config.assets.initialize_on_precompile = false
    config.action_mailer.default_url_options = { host: 'localhost:3000' }
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
