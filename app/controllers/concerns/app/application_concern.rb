module App::ApplicationConcern
  extend ActiveSupport::Concern

  included do
    include App::AuthenticateJwt
  end

  private
    def user
      App::User.find_by(id: jwt_payload['user_id'])
    rescue
      nil
    end

    def user_id
      user.nil? ? nil : user&.id
    end

    def total_balance
      user&.user_wallets&.lock&.order(id: :asc)&.last&.total.to_i
    end
end
