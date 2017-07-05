class AddAttachmentsToProposals < ActiveRecord::Migration[5.0]
  def change
    add_column :proposals, :attachments, :json
  end
end
