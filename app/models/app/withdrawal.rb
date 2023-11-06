class App::Withdrawal < ApplicationRecord
  belongs_to :user, class_name: "App::User"

  # Polymorphic Associations
  has_many :user_wallets, as: :assignable, foreign_key: 'assignable_id'

  # Validations
  validates :amount, presence: true
  validates :bank_name, presence: true
  validates :bank_account_number, presence: true
  validates :bank_account_name, presence: true

  validates :amount, numericality: { greater_than: 0 }
  validates :status, allow_nil: true, allow_blank: true, inclusion: { in: WITHDRAWALS_STATUS }

  # Insufficient user balance
  validate do
    errors.add(:base, 'Insufficient balance') if insufficient_user_balance(user_id, amount)
  end

  # Callbacks
  before_create :set_code

  def set_code
    loop do
      secure_random = "WD-#{SecureRandom.hex(5).upcase}"
      return self.code = secure_random unless App::Withdrawal.exists?(code: secure_random)
    end
  end

  # Callbacks
  before_create do
    self.status = 'PENDING'
  end

  # Callbacks
  after_create_commit do
    # Create disbursement with payment gateway, etc...
  end
end

# ## Schema Information
#
# Table name: `withdrawals`
#
# ### Columns
#
# Name                       | Type               | Attributes
# -------------------------- | ------------------ | ---------------------------
# **`id`**                   | `bigint`           | `not null, primary key`
# **`created_at`**           | `datetime`         | `not null`
# **`updated_at`**           | `datetime`         | `not null`
# **`user_id`**              | `bigint`           |
# **`code`**                 | `string`           |
# **`amount`**               | `decimal(26, 2)`   |
# **`bank_name`**            | `string`           |
# **`bank_account_number`**  | `string`           |
# **`bank_account_name`**    | `string`           |
# **`status`**               | `string`           |
#
# ### Indexes
#
# * `index_withdrawals_on_user_id`:
#     * **`user_id`**
#
# ### Foreign Keys
#
# * `fk_rails_...`:
#     * **`user_id => users.id`**
#
