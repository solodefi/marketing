json.extract! proposal, :id, :job_id, :price, :description, :start_date, :end_date, :user_id, :created_at, :updated_at
json.url proposal_url(proposal, format: :json)
