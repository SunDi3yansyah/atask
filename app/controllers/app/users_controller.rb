class App::UsersController < AppController
  include App::IsUser

  before_action :set_user, only: %i[ show ]

  # GET /app/users
  def index
    @users = App::User.order(created_at: :desc)

    @users = paginate @users, per_page: params[:_limit]

    api each_serializer(@users, App::UserSerializer)
  end

  # GET /app/users/:id
  def show
    api serializer(@user, App::UserSerializer)
  end

  private
    def set_user
      @user = validate_params App::User.find_by(id: params[:id])
    end
end
