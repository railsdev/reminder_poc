

json.array!(@reminders) do |reminder|
  json.extract! reminder, :user_id, :name, :fq_type, :interval, :fq_month, :fq_time, :fq_day, :status, :start_time
  json.url reminder_url(reminder, format: :json)
end

#  id                        :integer          not null, primary key
#  user_id                   :integer
#  name                      :string(255)
#  fq_type                   :string(255)
#  interval                  :integer
#  fq_month                  :integer
#  fq_time                   :time
#  created_at                :datetime
#  updated_at                :datetime
#  parent_id                 :integer
#  scheduled_reminders_count :integer
#  status                    :string(255)      default("unscheduled")
#  fq_day                    :integer
#  start_time                :datetime
