class AddColumnsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :first_name, :string, default: ""
    add_column :users, :last_name, :string, default: ""
    add_column :users, :birthday, :date
    add_column :users, :user_type, :integer, default: 0
    add_column :users, :photo_url, :string, default: ""
    add_column :users, :country, :string, default: ""
  end
end
