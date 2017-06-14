class AddProfessionIdToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :profession_id, :integer
  end
end
