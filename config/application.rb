require_relative "boot"

require "rails"
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
# require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
# require "action_mailbox/engine"
# require "action_text/engine"
require "action_view/railtie"
require "action_cable/engine"
# require "rails/test_unit/railtie"

Bundler.require(*Rails.groups)

Dotenv::Railtie.load

module Atask
  class Application < Rails::Application
    # Learn more: https://guides.rubyonrails.org/v6.0/configuring.html
    config.load_defaults 7.0
    config.time_zone = "Jakarta"
    config.eager_load_paths << Rails.root.join("lib")
    config.api_only = true

    # Additional configs
    config.generators do |g|
      g.helper = false
      g.jbuilder = false

      g.test_framework :rspec, controller_specs: false, view_specs: false
    end

    config.action_dispatch.rack_cache = {
      verbose: true,
      # File
      # metastore: "file:tmp/cache/rack/meta",
      # entitystore: "file:tmp/cache/rack/body",
      # Redis
      metastore: "#{ENV['REDIS_URL']}/metastore",
      entitystore: "#{ENV['REDIS_URL']}/entitystore",
      compress: true
    }

    config.exceptions_app = self.routes
    config.active_record.default_timezone = :local
    config.active_record.belongs_to_required_by_default = false
    config.active_record.cache_versioning = false
    config.active_record.index_nested_attribute_errors = true
    config.generators.system_tests = nil
    config.active_job.queue_adapter = :sidekiq
    config.cache_store = :redis_store, "#{ENV['REDIS_URL']}/cache"
    # config.action_cable.mount_path = "/cable"
    # config.action_cable.url = "wss://example.com/cable"
    config.action_cable.allowed_request_origins = [/http:\/\/*/, /https:\/\/*/]
    config.action_cable.disable_request_forgery_protection = true
    config.i18n.default_locale = :id
    config.i18n.available_locales = [:id, :en]
    config.public_file_server.enabled = true
  end
end
