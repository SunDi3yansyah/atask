require 'rails_helper'

RSpec.describe App::Account::SignIn, type: :model do
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
