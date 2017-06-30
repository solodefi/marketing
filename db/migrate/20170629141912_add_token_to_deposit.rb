class AddTokenToDeposit < ActiveRecord::Migration[5.0]
  def change
    add_column :deposits, :token, :string
  end
end
