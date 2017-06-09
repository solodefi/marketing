class AddCategoryIdsToJobs < ActiveRecord::Migration[5.0]
  def change
    add_column :jobs, :category_ids, :text
  end
end
