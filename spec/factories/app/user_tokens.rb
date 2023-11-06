FactoryBot.define do
  factory :app_user_token, class: 'App::UserToken' do
    association :user, factory: :app_user
    token { JsonWebToken.encode({ user_id: rand(100..1000) }) }
    refresh_token { SecureRandom.urlsafe_base64(64) }
    expired_at { Time.now + 2.hours }
    user_agent { Faker::Internet.user_agent }
  end
end

# ## Schema Information
#
# Table name: `user_tokens`
#
# ### Columns
#
# Name                 | Type               | Attributes
# -------------------- | ------------------ | ---------------------------
# **`id`**             | `bigint`           | `not null, primary key`
# **`created_at`**     | `datetime`         | `not null`
# **`updated_at`**     | `datetime`         | `not null`
# **`user_id`**        | `bigint`           |
# **`token`**          | `string`           |
# **`refresh_token`**  | `string`           |
# **`expired_at`**     | `datetime`         |
# **`user_agent`**     | `string`           |
#
# ### Indexes
#
# * `index_user_tokens_on_user_id`:
#     * **`user_id`**
#
# ### Foreign Keys
#
# * `fk_rails_...`:
#     * **`user_id => users.id`**
#
