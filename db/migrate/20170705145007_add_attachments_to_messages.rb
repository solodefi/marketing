class AddAttachmentsToMessages < ActiveRecord::Migration[5.0]
  def change
    add_column :messages, :attachments, :json
  end
end
