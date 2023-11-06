class CreateUserWallet < ActiveRecord::Migration[7.0]
  def change
    create_table :user_wallets do |t|
      t.timestamps

      t.references :user, foreign_key: true
      t.references :assignable, polymorphic: true
      t.string :in_out
      t.string :description
      t.decimal :amount, precision: 26, scale: 2
      t.decimal :total, precision: 26, scale: 2
    end
  end
end
