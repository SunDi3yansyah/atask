class CreateWithdrawal < ActiveRecord::Migration[7.0]
  def change
    create_table :withdrawals do |t|
      t.timestamps

      t.references :user, foreign_key: true
      t.string :code
      t.decimal :amount, precision: 26, scale: 2
      t.string :bank_name
      t.string :bank_account_number
      t.string :bank_account_name
      t.string :status
    end
  end
end
