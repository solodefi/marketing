class FixPostedbyColumnNameInJobs < ActiveRecord::Migration[5.0]
  def change
  	rename_column :jobs, :posted_by, :user_id
  end
end
