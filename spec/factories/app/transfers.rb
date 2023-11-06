FactoryBot.define do
  factory :app_transfer, class: 'App::Transfer' do
    from { nil }
    to { nil }
    code { SecureRandom.hex(6).upcase }
    amount { rand(10000..100000) }
    status { TRANSFERS_STATUS.sample }
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
