class AddStartedAtAndEndedAtToJob < ActiveRecord::Migration[5.0]
  def change
    add_column :jobs, :started_at, :datetime
    add_column :jobs, :ended_at, :datetime
  end
end
