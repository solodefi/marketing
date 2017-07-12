class CreatePortfolios < ActiveRecord::Migration[5.0]
  def change
    create_table :portfolios do |t|
      t.string :title
      t.text :overview
      t.integer :profession_id
      t.string :category_ids
      t.date :completion_date
      t.integer :user_id
      t.string :image

      t.timestamps
    end
  end
end
