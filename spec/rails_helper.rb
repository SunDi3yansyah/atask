# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'
ENV['RAILS_ENV'] = 'test'

# require_relative '../config/environment'
require File.expand_path('../config/environment', __dir__)

# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
# Add additional requires below this line. Rails is not loaded until this point!

require 'database_cleaner'
require 'rspec/retry'
require 'validates_email_format_of/rspec_matcher'

require 'webmock/rspec'
WebMock.disable_net_connect!(allow_localhost: true)

# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
# run as spec files by default. This means that files in spec/support that end
# in _spec.rb will both be required and run as specs, causing the specs to be
# run twice. It is recommended that you do not name files matching this glob to
# end with _spec.rb. You can configure this pattern with the --pattern
# option on the command line or in ~/.rspec, .rspec or `.rspec-local`.
#
# The following line is provided for convenience purposes. It has the downside
# of increasing the boot-up time by auto-requiring all files in the support
# directory. Alternatively, in the individual `*_spec.rb` files, manually
# require only the support files necessary.
#
Dir[Rails.root.join('spec', 'support', '**', '*.rb')].sort.each { |f| require f }

# Checks for pending migrations and applies them before tests are run.
# If you are not using ActiveRecord, you can remove these lines.
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  abort e.to_s.strip
end
RSpec.configure do |config|
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # You can uncomment this line to turn off ActiveRecord support entirely.
  # config.use_active_record = false

  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, type: :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://rspec.info/features/6-0/rspec-rails
  config.infer_spec_type_from_file_location!

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!
  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")



  # RSpec::Retry: https://github.com/NoRedInk/rspec-retry
  # RSpec::Retry adds a :retry option for intermittently failing rspec examples.
  # If an example has the :retry option, rspec will retry the example the specified number of times
  # until the example succeeds.
  #
  # show retry status in spec process
  config.verbose_retry = true
  # show exception that triggers a retry if verbose_retry is set to true
  config.display_try_failure_messages = true
  # run retry only on features
  config.around(:each) do |example|
    example.run_with_retry retry: 3
  end

  # factory_bot is a fixtures replacement with a straightforward definition syntax,
  # support for multiple build strategies (saved instances, unsaved instances,
  # attribute hashes, and stubbed objects), and support for multiple factories for
  # the same class (user, admin_user, and so on), including factory inheritance.
  config.include FactoryBot::Syntax::Methods

  # Set the host before hit the test request
  config.before(:all, type: :request) do
    host! 'localhost:4000'
  end

  # Set the default web mock
  config.before(:each) do
    # Create the stub request
  end

  config.before(:each, type: :request) do
    # Create the stub request
  end

  # Set the queue adapter before running the test job
  config.before(:all, type: :job) do
    ActiveJob::Base.queue_adapter = :test
  end

  # Database Cleaner is a set of gems containing strategies for cleaning your database in Ruby.
  #
  # The original use case was to ensure a clean state during tests. Each strategy is a small
  # amount of code but is code that is usually needed in any ruby app that is testing with a database.
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:all) do
    DatabaseCleaner.start
  end

  config.after(:all) do
    DatabaseCleaner.clean
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end

  # Callback for delete storages directory
  config.after(:all) do
    if Rails.env.test?
      FileUtils.rm_rf(Dir["#{Rails.root}/public/storages/test"])
    end
  end

  # Callback for delete all keys from redis
  config.after(:all) do
    $redis.del($redis.keys) if $redis.keys.present?
  end

  # Module for Support or Helper
  config.include ActiveJob::TestHelper

  config.include RequestSpecHelper
  config.include App::ControllerSpecHelper
end

# Shoulda Matchers provides RSpec- and Minitest-compatible one-liners to
# test common Rails functionality that,if written by hand, would be much
# longer, more complex, and error-prone.
Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

# Load shared examples
Dir['./spec/shared_examples/**/*.rb'].sort.each { |f| require f }
