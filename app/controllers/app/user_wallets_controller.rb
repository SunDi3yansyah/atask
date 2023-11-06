class App::UserWalletsController < AppController
  include App::IsUser

  before_action :set_user_wallet, only: %i[ show ]

  # GET /app/wallets
  def index
    @user_wallets = App::UserWallet.where(user_id: user_id).order(created_at: :desc)

    @user_wallets = paginate @user_wallets, per_page: params[:_limit]

    api each_serializer(@user_wallets, App::UserWalletSerializer)
  end

  # GET /app/wallets/:id
  def show
    api serializer(@user_wallet, App::UserWalletSerializer)
  end

  private
    def set_user_wallet
      @user_wallet = validate_params App::UserWallet.find_by(id: params[:id], user_id: user_id)
    end
end
