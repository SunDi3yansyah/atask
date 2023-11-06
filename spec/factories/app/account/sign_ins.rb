FactoryBot.define do
  factory :app_account_sign_in, class: 'App::Account::SignIn' do
    name { Faker::Name.name }
    phone { "+628#{rand(1000000000..9999999999)}" }
    email { Faker::Internet.free_email }
    password { SecureRandom.urlsafe_base64(5) }
  end
end

# ## Schema Information
#
# Table name: `users`
#
# ### Columns
#
# Name                   | Type               | Attributes
# ---------------------- | ------------------ | ---------------------------
# **`id`**               | `bigint`           | `not null, primary key`
# **`created_at`**       | `datetime`         | `not null`
# **`updated_at`**       | `datetime`         | `not null`
# **`name`**             | `string`           |
# **`phone`**            | `string`           |
# **`email`**            | `string`           |
# **`password_digest`**  | `string`           |
#
