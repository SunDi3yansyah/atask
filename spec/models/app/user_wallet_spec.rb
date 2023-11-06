require 'rails_helper'

RSpec.describe App::UserWallet, type: :model do
  describe 'Associations' do
    it { should belong_to(:user) }
    it { should belong_to(:assignable) }

    it { should belong_to(:transfer).with_foreign_key('assignable_id') }
    it { should belong_to(:withdrawal).with_foreign_key('assignable_id') }
  end

  describe 'Validates' do
    it { should validate_inclusion_of(:in_out).in_array(USER_WALLETS_IN_OUT) }
    it { should validate_numericality_of(:amount).is_greater_than(0) }

    context 'Custom validation' do
      let(:user) { create(:app_user) }

      before do
        @user_wallet = App::UserWallet.new({ user: user, in_out: 'OUT', amount: 1 })
        @user_wallet.save
      end

      it { expect(@user_wallet.save).to eq(false) }
      it { expect(@user_wallet.errors.messages[:base]).to include('Insufficient balance') }
    end
  end

  describe 'Callbacks' do
    context 'before_create' do
      let(:user_wallet) { create(:app_user_wallet, in_out: 'IN', total: 0) }

      it { expect(user_wallet.total).not_to be_nil }
      it { expect(user_wallet.total).to be > 1 }
    end
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
