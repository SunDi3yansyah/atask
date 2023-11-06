class App::WithdrawalSerializer < ApplicationSerializer
  attributes :id, :created_at, :updated_at, :code, :amount, :bank_name, :bank_account_number, :bank_account_name, :status

  belongs_to :user
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
