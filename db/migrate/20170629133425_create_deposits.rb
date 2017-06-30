class CreateDeposits < ActiveRecord::Migration[5.0]
  def change
    create_table :deposits do |t|
      t.float :amount
      t.integer :user_id

      t.timestamps
    end
  end
end
