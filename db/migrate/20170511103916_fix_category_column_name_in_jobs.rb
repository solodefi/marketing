class FixCategoryColumnNameInJobs < ActiveRecord::Migration[5.0]
  def change
  	rename_column :jobs, :categories, :category_ids
  end
end
