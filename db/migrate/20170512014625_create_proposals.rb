class CreateProposals < ActiveRecord::Migration[5.0]
  def change
    create_table :proposals do |t|
      t.integer :job_id, null: false, default: ""
      t.integer :price, default: 0
      t.text :description, default: ""
      t.date :start_date
      t.date :end_date
      t.integer :user_id, null: false, default: 0

      t.timestamps
    end
  end
end
