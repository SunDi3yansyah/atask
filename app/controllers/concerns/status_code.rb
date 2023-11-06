module StatusCode
  extend ActiveSupport::Concern

  included do
    def http_status(code = nil)
      code = code.present? ? code : params[:code].to_i
      if http_status_codes(code).present?
        api({ message: http_status_codes(code) }, code)
      else
        api({ message: 'Invalid HTTP Status Code' })
      end
    end

    def exception
      api({ message: http_status_codes(500) }, 500)
    end

    def status_code_404
      api({ message: http_status_codes(404) }, 404)
    end

    def status_code_422
      api({ message: http_status_codes(422) }, 422)
    end

    def status_code_500
      api({ message: http_status_codes(500) }, 500)
    end
  end
end
