class App::Transfer < ApplicationRecord
  # Bi-directional Associations
  belongs_to :user_sender, class_name: "App::User", foreign_key: 'from'
  belongs_to :user_receiver, class_name: "App::User", foreign_key: 'to'

  # Polymorphic Associations
  has_many :user_wallets, as: :assignable, foreign_key: 'assignable_id'

  # Validations
  validates :from, presence: true
  validates :to, presence: true
  validates :amount, presence: true

  validates :amount, numericality: { greater_than: 0 }
  validates :status, inclusion: { in: TRANSFERS_STATUS }

  # Invalid transfer destination user
  validate do
    errors.add(:base, 'Invalid transfer destination user') unless App::User.exists?(id: to)
  end
  # Cannot transfer balance to yourself
  validate do
    errors.add(:base, 'Cannot transfer balance to yourself') if from == to
  end
  # Insufficient user balance
  validate do
    errors.add(:base, 'Insufficient balance') if insufficient_user_balance(from, amount)
  end

  # Callbacks
  before_create :set_code

  def set_code
    loop do
      secure_random = "TRF-#{SecureRandom.hex(5).upcase}"
      return self.code = secure_random unless App::Transfer.exists?(code: secure_random)
    end
  end

  # Callbacks
  before_create do
    self.status = 'PENDING' unless status.present?
  end

  # Callbacks
  after_create do
    if status == 'PENDING'
      ActiveRecord::Base.transaction do
        subtraction = App::UserWallet.subtraction(
          {
            user: user_sender,
            assignable_type: 'App::Transfer',
            assignable_id: id,
            description: "Transfer a balance #{format_money(amount)} for #{user_receiver.name} - ID ##{code}",
            amount: amount
          }
        )

        addition = App::UserWallet.addition(
          {
            user: user_receiver,
            assignable_type: 'App::Transfer',
            assignable_id: id,
            description: "Transfer a balance #{format_money(amount)} from #{user_sender.name} - ID ##{code}",
            amount: amount
          }
        )

        on_update = self.class.find_by(id: id)
        on_update.status = 'SUCCESS'
        on_update.save(validate: false)
      end
    end
  end
end

# ## Schema Information
#
# Table name: `transfers`
#
# ### Columns
#
# Name              | Type               | Attributes
# ----------------- | ------------------ | ---------------------------
# **`id`**          | `bigint`           | `not null, primary key`
# **`created_at`**  | `datetime`         | `not null`
# **`updated_at`**  | `datetime`         | `not null`
# **`from`**        | `bigint`           |
# **`to`**          | `bigint`           |
# **`code`**        | `string`           |
# **`amount`**      | `decimal(26, 2)`   |
# **`status`**      | `string`           |
#
# ### Indexes
#
# * `index_transfers_on_from`:
#     * **`from`**
# * `index_transfers_on_to`:
#     * **`to`**
#
