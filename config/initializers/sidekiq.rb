Sidekiq.configure_server do |config|
  config.logger = Sidekiq::Logger.new($stdout)
  config.logger.level = Rails.logger.level
  config.logger.formatter = Sidekiq::Logger::Formatters::JSON.new
end
