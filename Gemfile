source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.2"

gem "rails", "~> 7.0.8"
gem "pg", "~> 1.5.4"
gem "puma", "~> 5.6.7"
# gem "jbuilder"
gem "redis", "~> 4.8.1"
# gem "kredis"
gem "bcrypt", "~> 3.1.19"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
gem "bootsnap", require: false
gem "rack-cors"

group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
end

group :development do
  # gem "spring"
end

# Additional Gems
group :development, :test, :staging do
  gem 'annotate', '~> 3.2.0'
  gem 'awesome_print', '~> 1.9.2'
  gem 'database_cleaner', '~> 2.0.2'
  gem 'factory_bot_rails', '~> 6.2.0'
  gem 'faker', '~> 3.2.2'
  gem 'i18n-tasks', '~> 1.0.13'
  gem 'rspec-rails', '~> 6.0.3'
  gem 'rspec-retry', '~> 0.6.2'
  gem 'shoulda-matchers', '~> 5.3.0'
  gem 'webmock', '~> 3.19.1'
end

gem 'active_model_serializers', '~> 0.10.14'
gem 'api-pagination', '~> 5.0.0'
gem 'dotenv-rails', '~> 2.8.1'
gem 'httparty', '~> 0.21.0'
gem 'jwt', '~> 2.7.1'
gem 'kaminari', '~> 1.2.2'
gem 'oj', '~> 3.16.1'
gem 'rack-cache', '~> 1.14.0'
gem 'rails-i18n', '~> 7.0.8'
gem 'redis-namespace', '~> 1.11.0'
gem 'redis-rack-cache', '~> 2.2.1'
gem 'redis-rails', '~> 5.0.2'
gem 'sidekiq', '~> 7.2.0'
gem 'validates_email_format_of', '~> 1.7.2'
