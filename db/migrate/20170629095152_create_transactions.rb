class CreateTransactions < ActiveRecord::Migration[5.0]
  def change
    create_table :transactions do |t|
      t.float :amount
      t.integer :sender_id
      t.integer :recipient_id
      t.integer :status

      t.timestamps
    end
  end
end
