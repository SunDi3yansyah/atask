require 'rails_helper'

RSpec.describe App::User, type: :model do
  it { should have_secure_password(:password) }

  describe 'Associations' do
    it { should have_many(:user_tokens).with_foreign_key('user_id') }
    it { should have_many(:withdrawals).with_foreign_key('user_id') }

    it { should have_many(:from_transfers).with_foreign_key('from') }
    it { should have_many(:to_transfers).with_foreign_key('to') }
  end

  describe 'Validates' do
    it { should validate_uniqueness_of(:phone).case_insensitive.allow_nil.allow_blank }
    it { should allow_value('+6281234567890').for(:phone) }
    it { should_not allow_value('Alphabet').for(:phone) }
    it { should_not allow_value('Symbol~!@').for(:phone) }

    it { should validate_uniqueness_of(:email).case_insensitive.allow_nil.allow_blank }
    it { should validate_email_format_of(:email).with_message(I18n.t('errors.messages.invalid')) }
  end

  describe 'Callbacks' do

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
