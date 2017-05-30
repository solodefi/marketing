class AddPostcodeToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :postcode, :string, default: ""
  end
end
