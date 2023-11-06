class CreateTransfer < ActiveRecord::Migration[7.0]
  def change
    create_table :transfers do |t|
      t.timestamps

      t.bigint :from
      t.bigint :to
      t.string :code
      t.decimal :amount, precision: 26, scale: 2
      t.string :status
    end
    add_index :transfers, :from
    add_index :transfers, :to
  end
end
