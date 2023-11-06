module Extras
  extend ActiveSupport::Concern

  included do
    def index
      data = {
        message: "Welcome to #{APP_NAME} API",
        initializers: {
          app_name: APP_NAME,
          tagline: TAGLINE,
        },
        environments: {
          ruby_version: RUBY_VERSION,
          rails_version: Rails.version,
          gem_version: `gem -v`.delete("\n"),
          environment: Rails.env,
        },
        version: %x|git rev-parse HEAD|.delete("\n"),
        documentation: '',
        modules: {}
      }

      api(data)
    end
  end
end
