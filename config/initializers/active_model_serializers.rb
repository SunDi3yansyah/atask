ActiveModelSerializers.config.adapter = :attributes
# Enable Logging
ActiveModelSerializers.logger = Logger.new(STDOUT) unless Rails.env.test?

# Disable Logging
# ActiveSupport::Notifications.unsubscribe(ActiveModelSerializers::Logging::RENDER_EVENT)
