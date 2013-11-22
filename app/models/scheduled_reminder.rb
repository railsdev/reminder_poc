# == Schema Information
#
# Table name: scheduled_reminders
#
#  id          :integer          not null, primary key
#  reminder_id :integer
#  run_at      :datetime
#  status      :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

class ScheduledReminder < ActiveRecord::Base
  belongs_to :reminder
end
