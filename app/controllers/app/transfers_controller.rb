class App::TransfersController < AppController
  include App::IsUser

  before_action :set_transfer, only: %i[ show ]

  # GET /app/transfers
  def index
    @transfers = App::Transfer.where(from: user_id).order(created_at: :desc)

    @transfers = paginate @transfers, per_page: params[:_limit]

    api each_serializer(@transfers, App::TransferSerializer)
  end

  # GET /app/transfers/:id
  def show
    api serializer(@transfer, App::TransferSerializer)
  end

  # POST /app/transfers
  def create
    @transfer = App::Transfer.new(transfer_params)

    if @transfer.save
      api serializer(@transfer, App::TransferSerializer), 201
    else
      api({ message: @transfer.errors }, 422)
    end
  end

  private
    def set_transfer
      @transfer = validate_params App::Transfer.find_by(id: params[:id], from: user_id)
    end

    def transfer_params
      params.require(:transfer).permit(:to, :amount).merge(from: user_id, status: 'PENDING')
    end
end
