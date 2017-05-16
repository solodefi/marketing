class CreateJobs < ActiveRecord::Migration[5.0]
  def change
    create_table :jobs do |t|
      t.text :categories, array: true, default: []
      t.string :title, default: ""
      t.integer :price, default: 0
      t.text :description, default: ""
      t.date :start_date
      t.date :end_date
      t.integer :posted_by, default: 0

      t.timestamps
    end
  end
end
