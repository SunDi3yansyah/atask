FactoryBot.define do
  factory :app_user, class: 'App::User' do
    name { Faker::Name.name }
    phone { "+628#{rand(1000000000..9999999999)}" }
    email { Faker::Internet.unique.email(domain: 'gmail.com') }
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
