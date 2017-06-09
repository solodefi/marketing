class AddFreelancerIdToJob < ActiveRecord::Migration[5.0]
  def change
    add_column :jobs, :freelancer_id, :integer
  end
end
