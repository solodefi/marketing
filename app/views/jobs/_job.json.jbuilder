json.extract! job, :id, :categories, :title, :price, :description, :start_date, :end_date, :posted_by, :created_at, :updated_at
json.url job_url(job, format: :json)
