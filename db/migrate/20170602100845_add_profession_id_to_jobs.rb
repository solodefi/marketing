class AddProfessionIdToJobs < ActiveRecord::Migration[5.0]
  def change
    add_column :jobs, :profession_id, :integer, default: 0
  end
end
