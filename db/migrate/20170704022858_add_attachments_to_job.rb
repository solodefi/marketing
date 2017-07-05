class AddAttachmentsToJob < ActiveRecord::Migration[5.0]
  def change
    add_column :jobs, :attachments, :json
  end
end
