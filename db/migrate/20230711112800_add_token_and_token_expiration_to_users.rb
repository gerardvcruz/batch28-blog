class AddTokenAndTokenExpirationToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :token, :string
    add_column :users, :token_expiration, :datetime
  end
end
