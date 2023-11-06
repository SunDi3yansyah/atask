class App::UserWallet < ApplicationRecord
  belongs_to :user, class_name: "App::User"
  # Polymorphic Associations
  belongs_to :assignable, polymorphic: true

  # Scopes
  belongs_to :transfer, foreign_key: 'assignable_id'
  belongs_to :withdrawal, foreign_key: 'assignable_id'

  # Validations
  validates :in_out, inclusion: { in: USER_WALLETS_IN_OUT }
  validates :amount, numericality: { greater_than: 0 }

  # Insufficient balance
  validate do
    last_total = App::UserWallet.lock.where(user_id: user_id).order(id: :asc).last&.total.to_i

    if in_out == 'OUT'
      errors.add(:base, 'Insufficient balance') if last_total - amount.to_i < 0
    end
  end

  # Callbacks
  before_create do
    last_total = App::UserWallet.lock.where(user_id: user_id).order(id: :asc).last&.total.to_i

    if in_out == 'IN'
      self.total = last_total + amount
    elsif in_out == 'OUT'
      self.total = last_total - amount
    else
      raise StandardError, '[ERROR] Set total for amount'
    end
  end

  # Methods
  def self.addition(options = {})
    create!(
      user: options[:user],
      assignable_type: options[:assignable_type],
      assignable_id: options[:assignable_id],
      in_out: 'IN',
      description: options[:description],
      amount: options[:amount]
    )
  end

  def self.subtraction(options = {})
    create!(
      user: options[:user],
      assignable_type: options[:assignable_type],
      assignable_id: options[:assignable_id],
      in_out: 'OUT',
      description: options[:description],
      amount: options[:amount]
    )
  end
end

# ## Schema Information
#
# Table name: `user_wallets`
#
# ### Columns
#
# Name                   | Type               | Attributes
# ---------------------- | ------------------ | ---------------------------
# **`id`**               | `bigint`           | `not null, primary key`
# **`created_at`**       | `datetime`         | `not null`
# **`updated_at`**       | `datetime`         | `not null`
# **`user_id`**          | `bigint`           |
# **`assignable_type`**  | `string`           |
# **`assignable_id`**    | `bigint`           |
# **`in_out`**           | `string`           |
# **`description`**      | `string`           |
# **`amount`**           | `decimal(26, 2)`   |
# **`total`**            | `decimal(26, 2)`   |
#
# ### Indexes
#
# * `index_user_wallets_on_assignable`:
#     * **`assignable_type`**
#     * **`assignable_id`**
# * `index_user_wallets_on_user_id`:
#     * **`user_id`**
#
# ### Foreign Keys
#
# * `fk_rails_...`:
#     * **`user_id => users.id`**
#
