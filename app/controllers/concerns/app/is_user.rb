module App::IsUser
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_jwt
  end
end
