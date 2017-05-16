ActiveAdmin.register Proposal do

	permit_params :job_id, :price, :description, :start_date, :end_date, :user_id

end
