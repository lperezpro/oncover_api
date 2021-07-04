class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :first_names
      t.string :last_names
      t.integer :phone_number
      t.date :date_birth
      t.string :document_id
      t.integer :gender
      t.string :email
      t.string :password_digest
      t.string :id_gg
      t.string :email_gg
      t.string :token_gg
      t.string :id_fb
      t.string :email_fb
      t.string :token_fb
      t.datetime :last_login
      t.boolean :validated_email, default: false
      t.string :email_token, default: nil, index: true
      t.datetime :email_token_sent_at, default: nil
      t.string :reset_password_token, default: nil, index: true
      t.datetime :reset_password_sent_at, default: nil
      t.datetime :last_reset_password
      t.timestamps
    end
  end
end
