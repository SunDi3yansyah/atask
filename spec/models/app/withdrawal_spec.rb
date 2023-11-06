require 'rails_helper'

RSpec.describe App::Withdrawal, type: :model do
  describe 'Associations' do
    it { should belong_to(:user) }

    it { should have_many(:user_wallets).with_foreign_key('assignable_id') }
  end

  describe 'Validates' do
    it { should validate_presence_of(:amount) }
    it { should validate_presence_of(:bank_name) }
    it { should validate_presence_of(:bank_account_number) }
    it { should validate_presence_of(:bank_account_name) }

    it { should validate_numericality_of(:amount).is_greater_than(0) }
    it { should validate_inclusion_of(:status).in_array(WITHDRAWALS_STATUS).allow_nil.allow_blank }

    context 'Custom validation' do
      let(:user) { create(:app_user) }

      before do
        @transfer = App::Withdrawal.new({ user: user, amount: 10_000 })
        @transfer.save
      end

      it { expect(@transfer.save).to eq(false) }
      it { expect(@transfer.errors.messages[:base]).to include('Insufficient balance') }
    end
  end

  describe 'Callbacks' do
    context 'before_create' do
      let!(:user) { create(:app_user) }
      let!(:user_wallet) { create(:app_user_wallet, user: user, in_out: 'IN', amount: 10_000) }
      let!(:withdrawal) { create(:app_withdrawal, user: user, amount: 10_000, status: nil) }

      it { expect(withdrawal.code).not_to be_nil }
      it { expect(withdrawal.status).to eq('PENDING') }
    end
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
