FactoryBot.define do
  factory :app_user_wallet, class: 'App::UserWallet' do
    association :user, factory: :app_user
    assignable { nil }
    in_out { USER_WALLETS_IN_OUT.sample }
    description { Faker::Lorem.paragraph }
    amount { rand(10..100000) }
    total { rand(10..100000) }
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
