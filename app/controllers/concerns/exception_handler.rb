module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from NoMemoryError, ScriptError, SecurityError, SignalException, StandardError, SystemExit, SystemStackError do |exception|
      exception_notification(exception)
      if Rails.env.development? || Rails.env.test? || Rails.env.staging?
        api({ message: exception.message, backtraces: exception.backtrace }, 500)
      else
        api({ message: http_status_codes(500) }, 500)
      end
    end

    rescue_from Timeout::Error do |exception|
      exception_notification(exception)
      api({ message: http_status_codes(500) }, 500)
    end

    rescue_from ActionController::InvalidAuthenticityToken do |exception|
      api({ message: http_status_codes(500) }, 500)
    end

    rescue_from ActionController::UnknownFormat do |exception|
      api({ message: http_status_codes(500) }, 500)
    end

    rescue_from ActionController::UnknownHttpMethod do |exception|
      api({ message: http_status_codes(500) }, 500)
    end

    rescue_from ActiveRecord::RecordNotUnique do |exception|
      api({ message: exception.message.split('(')[1].delete(')=').to_s.capitalize + ' has already been taken' }, 422)
    end

    rescue_from ActionController::BadRequest do |exception|
      api({ message: http_status_codes(400) }, 400)
    end

    rescue_from ActionController::RoutingError do |exception|
      api({ message: http_status_codes(404) }, 404)
    end

    rescue_from ActiveRecord::RecordNotFound do |exception|
      api({ message: http_status_codes(404) }, 404)
    end

    rescue_from JSON::ParserError do |exception|
      api({ message: http_status_codes(422) }, 422)
    end

    rescue_from ActionController::ParameterMissing do |exception|
      api({ message: message_validation(exception.message) }, 422)
    end

    rescue_from ActiveRecord::RecordInvalid do |exception|
      api({ message: message_validation(exception.message) }, 422)
    end

    rescue_from ActiveRecord::InvalidForeignKey do |exception|
      api({ message: I18n.t(:foreign_key_is_not_present_in_table) }, 422)
    end

    rescue_from Mime::Type::InvalidMimeType do |exception|
      api({ message: message_validation(exception.message) }, 422)
    end

    # rescue_from BCrypt::Errors::InvalidHash do |exception|
    #   api({ message: I18n.t(:bcrypt_errors_invalid_hash) }, 422)
    # end

    # Ruby >= 2.7.5, Rails >= 6.1.4
    rescue_from Date::Error do |exception|
      api({ message: exception.message.capitalize }, 422)
    end
  end

  private
    def process_action(*args)
      super
    rescue ActionDispatch::Http::Parameters::ParseError => exception
      api({ message: http_status_codes(400) }, 400)
    end

    def exception_notification(exception)
      # Create exception notification
    end
end
