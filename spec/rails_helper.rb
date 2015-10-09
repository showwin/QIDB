# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] = 'test'
require 'spec_helper'
require 'factory_girl_rails'
require 'database_cleaner'
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'

require 'capybara/rails'
require 'capybara/rspec'
require 'capybara/poltergeist'

require 'simplecov'
require 'coveralls'
SimpleCov.start 'rails'
Coveralls.wear!

Capybara.javascript_driver = :poltergeist

Capybara.register_driver :poltergeist do |app|
  # JS Error disable.
  Capybara::Poltergeist::Driver.new(app, js_errors: false, timeout: 240)
end

Capybara.default_driver   = :rack_test
Capybara.default_selector = :css
Capybara.default_max_wait_time = 5

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
# ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  # config.fixture_path = '#{::Rails.root}/spec/fixtures'

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = false

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
  config.infer_spec_type_from_file_location!

  config.include FactoryGirl::Syntax::Methods
  config.include Capybara::DSL
  config.before :each do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.start
  end

  config.after :each do
    Capybara.reset_sessions!
    DatabaseCleaner.clean
    FactoryGirl.reload
  end
end
