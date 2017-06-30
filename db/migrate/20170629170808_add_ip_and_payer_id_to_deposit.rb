class AddIpAndPayerIdToDeposit < ActiveRecord::Migration[5.0]
  def change
    add_column :deposits, :ip, :string
    add_column :deposits, :payer_id, :string
  end
end
