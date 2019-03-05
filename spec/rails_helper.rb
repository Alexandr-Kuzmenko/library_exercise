ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
abort('The Rails environment is running in production mode!') if Rails.env.production?
Object.send(:remove_const, :ActiveRecord)

require 'spec_helper'
require 'rspec/rails'
require 'mongoid'
require 'mongoid-rspec'
require 'rails/mongoid'
require 'capybara/rails'
require 'capybara/rspec'
require 'carrierwave/test/matchers'
require 'database_cleaner'
require 'devise'
require 'faker'
require 'selenium-webdriver'
require 'support/factory_bot'

Mongoid.load!(Rails.root.join('config', 'mongoid.yml'))
# Dir[Rails.root.join('spec', 'support', '**', '*.rb')].each { |f| require f }

# begin
#   ActiveRecord::Migration.maintain_test_schema!
# rescue ActiveRecord::PendingMigrationError => e
#   puts e.to_s.strip
#   exit 1
# end

Capybara.register_driver :selenium_chrome do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end
Capybara.javascript_driver = :selenium_chrome
Capybara.server_host = 'localhost'
Capybara.server_port = 3000

DatabaseCleaner[:mongoid].strategy = :truncation

RSpec.configure do |config|
  config.mock_with :rspec
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  # config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  # config.use_transactional_fixtures = true

  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, :type => :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://relishapp.com/rspec/rspec-rails/docs
  # config.infer_spec_type_from_file_location!

  # Filter lines from Rails gems in backtraces.
  # config.filter_rails_from_backtrace!
  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")
  config.include Mongoid::Matchers, type: :model
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include Devise::Test::ControllerHelpers, type: :view
  config.include Devise::Test::IntegrationHelpers, type: :request
  config.include Capybara::DSL
  config.include FactoryBot::Syntax::Methods
  config.include Warden::Test::Helpers

  config.before(:suite) do
    DatabaseCleaner[:mongoid].clean_with(:truncation)
    DatabaseCleaner[:mongoid].orm = 'mongoid'
  end
  config.before(:each) do
    DatabaseCleaner[:mongoid].start
  end
  config.after(:each) do
    DatabaseCleaner[:mongoid].clean
  end
end
