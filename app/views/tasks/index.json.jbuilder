json.array!(@tasks) do |task|
  json.extract! task, :id, :name, :start_time, :end_time
  json.title task.name
  json.start task.start_time
  json.end task.end_time
  json.url project_task_url(task.project_id, task, format: :html)
end