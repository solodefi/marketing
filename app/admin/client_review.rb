ActiveAdmin.register ClientReview do
  permit_params :job_id, :score, :notes


  show do
    attributes_table do
      row :id
      row :job
      row :score
      row :notes
      row :created_at
      row :updated_at
      row('Written By') {|r| r.job.freelancer}
      row('Wrote To') {|r| r.job.user}
    end
  end

end
