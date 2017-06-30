class AddJobIdToTransactions < ActiveRecord::Migration[5.0]
  def change
    add_column :transactions, :job_id, :integer
  end
end
