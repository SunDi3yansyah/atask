FactoryBot.define do
  factory :app_withdrawal, class: 'App::Withdrawal' do
    association :user, factory: :app_user
    code { SecureRandom.hex(6).upcase }
    amount { rand(10..100000) }
    bank_name { %w[BRI BNI Mandiri BCA].sample }
    bank_account_number { rand.to_s.reverse[0..9] }
    bank_account_name { Faker::Name.name }
    status { WITHDRAWALS_STATUS.sample }
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
