class App::User < ApplicationRecord
  has_secure_password

  has_many :user_tokens, foreign_key: 'user_id'
  has_many :withdrawals, foreign_key: 'user_id'

  # Bi-directional Associations
  has_many :from_transfers, class_name: "App::Transfer", foreign_key: 'from'
  has_many :to_transfers, class_name: "App::Transfer", foreign_key: 'to'

  # Validations
  validates :phone, allow_nil: true, allow_blank: true, uniqueness: { case_sensitive: false }, format: { with: /\A(\+628)[0-9]{8,}+\Z/ }
  validates :email, allow_nil: true, allow_blank: true, uniqueness: { case_sensitive: false }
  validates_email_format_of :email, message: I18n.t('errors.messages.invalid'), check_mx: true, mx_message: I18n.t('unknown_email_provider'), allow_nil: true, allow_blank: true
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
