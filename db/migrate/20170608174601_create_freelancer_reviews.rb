class CreateFreelancerReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :freelancer_reviews do |t|
      t.integer :job_id, null: false, default: 0
      t.float :score
      t.text :notes

      t.timestamps
    end
  end
end
