ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'factory_girl_rails'
require 'spec_helper'
require 'rspec/rails'
require 'capybara/rspec'
require 'database_cleaner'
ActiveRecord::Migration.maintain_test_schema!
DatabaseCleaner.strategy = :truncation

RSpec.configure do |config|
  config.use_transactional_fixtures = false
  config.include Capybara::DSL
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
  config.include FactoryGirl::Syntax::Methods
  Capybara.javascript_driver = :webkit
end
