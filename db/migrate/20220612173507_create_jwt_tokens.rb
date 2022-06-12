class CreateJwtTokens < ActiveRecord::Migration[7.0]
  def change
    create_table :jwt_tokens do |t|
      t.references :user, foreign_key: { on_delete: :cascade }
      t.string :token
      t.datetime :exp

      t.timestamps
    end
  end
end
