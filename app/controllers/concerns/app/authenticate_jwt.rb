module App::AuthenticateJwt
  extend ActiveSupport::Concern

  included do
  end

  private
    def authenticate_jwt
      if !jwt_payload || !JsonWebToken.valid_payload(jwt_payload)
        return api({ message: http_status_codes(401), failure: 'INCORRECT_TOKEN' }, 401)
      end

      current_user!

      return api({ message: http_status_codes(401), failure: 'USER_DOES_NOT_EXIST' }, 401) unless @current_user

      if App::UserToken.find_by(token: request_token)
        @current_user
      else
        api({ message: http_status_codes(401), failure: 'TOKEN_DOES_NOT_EXIST' }, 401)
      end
    end

    def have_correct_token?
      if !jwt_payload || !JsonWebToken.valid_payload(jwt_payload)
        false
      else
        true
      end
    end

    def request_token
      begin
        request.headers['X-AUTH-TOKEN'].split(' ').last
      rescue
        params[:access_token].split(' ').last
      end
    end

    def jwt_payload
      JsonWebToken.decode(request_token).first
    rescue
      nil
    end

    def current_user!
      @current_user = App::User.find_by(id: jwt_payload['user_id'])
    end
end
