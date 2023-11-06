module Response
  extend ActiveSupport::Concern

  included do
    # before_action :check_process_sidekiq
    before_action :set_headers
  end

  private
    def api(data, status = 200, location = nil)
      payload = {
        response: {
          status: status,
          message: http_status_codes(status),
          url: request.original_url
        },
        data: data.nil? ? nil : (JSON.parse(data) rescue data)
      }

      render json: Rails.env.production? ? payload : JSON.pretty_generate(payload.as_json), status: status, location: location
    end

    def http_message(message = nil, code = 200)
      if code.present?
        api({ message: message }, code)
      else
        api({ message: message })
      end
    end

    def each_serializer(resource, serializer, options = {})
      ActiveModelSerializers::SerializableResource.new(resource, each_serializer: serializer, options: options)
    end

    def serializer(resource, serializer, options = {})
      ActiveModelSerializers::SerializableResource.new(resource, serializer: serializer, options: options)
    end

    def check_process_sidekiq
      unless Rails.env.test?
        if Sidekiq::ProcessSet.new.size <= 0
          raise StandardError, 'Sidekiq not running! Please run `sidekiq` before trying to start your application'
        end
      end
    end

    def set_headers
      # Additional to set in header
    end
end
