class AddPostcodeToJobs < ActiveRecord::Migration[5.0]
  def change
    add_column :jobs, :postcode, :string, default: ""
  end
end
