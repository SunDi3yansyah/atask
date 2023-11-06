include ApplicationHelper

module App::ApplicationHelper
  def insufficient_user_balance(user_id, amount)
    total = App::UserWallet.lock.where(user_id: user_id).order(id: :asc).last&.total.to_i

    (total - amount.to_i) < 0
  end
end
