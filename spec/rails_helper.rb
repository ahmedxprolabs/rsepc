require 'simplecov'
SimpleCov.start 'rails' do
  minimum_coverage 90
end

# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'

# Add additional requires below this line. Rails is not loaded until this point!
# For example: require 'capybara/rspec'

# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
# run as spec files by default.
# Rails.root.glob('spec/support/**/*.rb').sort_by(&:to_s).each { |f| require f }

# Ensures that the test database schema matches the current schema file.
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  abort e.to_s.strip
end

RSpec.configure do |config|
  # Fixture directory (used only if you still use Rails fixtures)
  config.fixture_paths = [Rails.root.join('spec/fixtures')]

  # Run examples in a transaction
  config.use_transactional_fixtures = true

  # Uncomment if you want RSpec to guess spec type by file location
  # config.infer_spec_type_from_file_location!

  # Filter out Rails gems in backtraces
  config.filter_rails_from_backtrace!

  # ✅ FactoryBot shorthand methods (create, build, etc.)
  config.include FactoryBot::Syntax::Methods
end

# ✅ Shoulda Matchers configuration
Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end
