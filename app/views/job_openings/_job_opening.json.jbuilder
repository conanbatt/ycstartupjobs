json.extract! job_opening, :id, :title, :locations, :commitment, :team, :description, :salary, :created_at, :updated_at
json.url job_opening_url(job_opening, format: :json)
