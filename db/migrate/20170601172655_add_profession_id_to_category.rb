class AddProfessionIdToCategory < ActiveRecord::Migration[5.0]
  def change
    add_column :categories, :profession_id, :integer, null:false, default: 0
  end
end
