class AddEmailVerificationTokenOnUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :email_verification_token, :string, index: {unique: true}
  end
end
