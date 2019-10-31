class CreateTokens < ActiveRecord::Migration[5.2]
  def change
    create_table :tokens do |t|
      t.string :token, null: false, comment: "token"
      t.integer :user_id, null: false, comment: "用户ID"
      t.datetime :created_at
      t.datetime :valid_at

      t.timestamps
    end
  end
end
