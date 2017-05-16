class RemoveCategoryIdsFromJobs < ActiveRecord::Migration[5.0]
  def change
  	remove_column :jobs, :category_ids
  end
end
