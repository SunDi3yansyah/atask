class App::UserToken < ApplicationRecord
  belongs_to :user, class_name: "App::User"
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
