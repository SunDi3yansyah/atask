class App::TransferSerializer < ApplicationSerializer
  attributes :id, :created_at, :updated_at, :from, :to, :code, :amount, :status
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
