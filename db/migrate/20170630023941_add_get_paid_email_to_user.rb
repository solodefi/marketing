class AddGetPaidEmailToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :get_paid_email, :string
  end
end
