class App::UserWalletSerializer < ApplicationSerializer
  attributes :id, :created_at, :updated_at, :in_out, :description, :amount, :total

  belongs_to :user
  belongs_to :assignable
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
