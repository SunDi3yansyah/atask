module App::ControllerSpecHelper
  def user_token_generator(user)
    token = JsonWebToken.encode(user_id: user.id)
    FactoryBot.create(:app_user_token, user: user, token: token)
    token
  end

  def user_expired_token_generator(user)
    JsonWebToken.encode({ user_id: user.id, exp: Time.now.to_i - 10 })
  end

  def user_valid_headers
    {
      'Content-Type': 'application/json',
      'X-AUTH-TOKEN': "Token #{user_token_generator(user)}"
    }
  end
end
