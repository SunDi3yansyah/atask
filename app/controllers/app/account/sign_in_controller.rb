class App::Account::SignInController < AppController
  # POST /app/account/sign-in
  def create
    ActiveRecord::Base.transaction do
      return api({ message: "Identity #{I18n.t('errors.messages.blank')}" }, 422) unless sign_in_params[:identity].present?
      return api({ message: "Password #{I18n.t('errors.messages.blank')}" }, 422) unless sign_in_params[:password].present?

      user = App::Account::SignIn.find_by(phone: sign_in_params[:identity]) ||
        App::Account::SignIn.find_by(email: sign_in_params[:identity])

      return api({ message: I18n.t(:account_identity_does_not_exist) }, 422) unless user.present?
      return api({ message: I18n.t(:account_password_does_not_exist) }, 422) unless user.password_digest.present?
      return api({ message: I18n.t(:account_password_is_invalid) }, 422) unless user.authenticate(sign_in_params[:password]).present?

      expired_at = generate_expired_jwt
      refresh_token = SecureRandom.urlsafe_base64(64)
      token = JsonWebToken.encode( { user_id: user.id, exp: expired_at.to_i })

      user_token = user.user_tokens.find_or_create_by!(token: token)
      user_token.update!(
        refresh_token: refresh_token,
        expired_at: expired_at,
        user_agent: request.headers['User-Agent']
      )

      api(
        {
          message: I18n.t(:account_successfully_logged_in),
          token: token,
          expired_at: {
            format_integer: (Time.at(JsonWebToken.decode(token).first['exp']) - 1.minutes).to_i,
            format_datetime: Time.at(JsonWebToken.decode(token).first['exp']) - 1.minutes
          }
        }
      )
    end
  end

  private
    def sign_in_params
      params.require(:sign_in).permit(:identity, :password)
    end
end
