class App::WithdrawalsController < AppController
  include App::IsUser

  before_action :set_withdrawal, only: %i[ show ]

  # GET /app/withdrawals
  def index
    @withdrawals = App::Withdrawal.where(user_id: user_id).order(created_at: :desc)

    @withdrawals = paginate @withdrawals, per_page: params[:_limit]

    api each_serializer(@withdrawals, App::WithdrawalSerializer)
  end

  # GET /app/withdrawals/:id
  def show
    api serializer(@withdrawal, App::WithdrawalSerializer)
  end

  # POST /app/withdrawals
  def create
    @withdrawal = App::Withdrawal.new(withdrawal_params)

    if @withdrawal.save
      api serializer(@withdrawal, App::WithdrawalSerializer), 201
    else
      api({ message: @withdrawal.errors }, 422)
    end
  end

  private
    def set_withdrawal
      @withdrawal = validate_params App::Withdrawal.find_by(id: params[:id], user_id: user_id)
    end

    def withdrawal_params
      params.require(:withdrawal).permit(
        :amount, :bank_name, :bank_account_number, :bank_account_name
      ).merge(user_id: user_id)
    end
end
