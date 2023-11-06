require 'rails_helper'

RSpec.describe App::Transfer, type: :model do
  describe 'Associations' do
    it { should belong_to(:user_sender).with_foreign_key('from') }
    it { should belong_to(:user_receiver).with_foreign_key('to') }

    it { should have_many(:user_wallets).with_foreign_key('assignable_id') }
  end

  describe 'Validates' do
    it { should validate_presence_of(:from) }
    it { should validate_presence_of(:to) }
    it { should validate_presence_of(:amount) }

    it { should validate_numericality_of(:amount).is_greater_than(0) }
    it { should validate_inclusion_of(:status).in_array(TRANSFERS_STATUS) }

    context 'Custom validation' do
      let(:from) { create(:app_user).id }
      let(:to) { nil }

      before do
        @transfer = App::Transfer.new({ from: from, to: to, amount: 10_000 })
        @transfer.save
      end

      it { expect(@transfer.save).to eq(false) }
      it { expect(@transfer.errors.messages[:base]).to include('Invalid transfer destination user') }
      it { expect(@transfer.errors.messages[:base]).to include('Insufficient balance') }

      context 'Cannot transfer balance to yourself' do
        let!(:to) { from }

        it { expect(@transfer.errors.messages[:base]).to include('Cannot transfer balance to yourself') }
      end
    end
  end

  describe 'Callbacks' do
    context 'before_create' do
      let!(:from) { create(:app_user) }
      let!(:user_wallet) { create(:app_user_wallet, user: from, in_out: 'IN', amount: 10_000) }
      let!(:to) { create(:app_user) }
      let!(:transfer) { create(:app_transfer, from: from.id, to: to.id, amount: 10_000, status: 'PENDING') }

      it { expect(transfer.code).not_to be_nil }
      it { expect(transfer.status).to eq('PENDING') }
      it { expect(App::UserWallet.all.size).to eq(3) }
    end
  end
end

# ## Schema Information
#
# Table name: `transfers`
#
# ### Columns
#
# Name              | Type               | Attributes
# ----------------- | ------------------ | ---------------------------
# **`id`**          | `bigint`           | `not null, primary key`
# **`created_at`**  | `datetime`         | `not null`
# **`updated_at`**  | `datetime`         | `not null`
# **`from`**        | `bigint`           |
# **`to`**          | `bigint`           |
# **`code`**        | `string`           |
# **`amount`**      | `decimal(26, 2)`   |
# **`status`**      | `string`           |
#
# ### Indexes
#
# * `index_transfers_on_from`:
#     * **`from`**
# * `index_transfers_on_to`:
#     * **`to`**
#
