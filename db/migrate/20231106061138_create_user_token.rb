class CreateUserToken < ActiveRecord::Migration[7.0]
  def change
    create_table :user_tokens do |t|
      t.timestamps

      t.references :user, foreign_key: true
      t.string :token
      t.string :refresh_token
      t.datetime :expired_at
      t.string :user_agent
    end
  end
end
