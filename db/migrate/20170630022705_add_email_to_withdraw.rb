class AddEmailToWithdraw < ActiveRecord::Migration[5.0]
  def change
    add_column :withdraws, :email, :string
  end
end
