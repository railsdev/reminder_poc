json.array!(@reminders) do |reminder|
  json.extract! reminder, :user_id, :name, :fq_type, :fq_interval, :fq_monthly_interval, :fq_time
  json.url reminder_url(reminder, format: :json)
end
