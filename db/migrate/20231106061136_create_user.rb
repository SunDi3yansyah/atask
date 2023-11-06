class CreateUser < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.timestamps

      t.string :name
      t.string :phone
      t.string :email
      t.string :password_digest
    end
  end
end
