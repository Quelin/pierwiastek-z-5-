json.array!(@activities) do |activity|
  json.extract! activity, :id, :start_time, :end_time, :task_id
  json.url activity_url(activity, format: :json)
end
