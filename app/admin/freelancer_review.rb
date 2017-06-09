ActiveAdmin.register FreelancerReview do

  permit_params :job_id, :score, :notes

  show do
    attributes_table do
      row :id
      row :job
      row :score
      row :notes
      row :created_at
      row :updated_at
      row('Written By') {|r| r.job.user}
      row('Wrote To') {|r| r.job.freelancer}
    end
  end

end
