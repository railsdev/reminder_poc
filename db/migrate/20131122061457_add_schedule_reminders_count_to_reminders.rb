class AddScheduleRemindersCountToReminders < ActiveRecord::Migration
  def change
    add_column :reminders, :scheduled_reminders_count, :integer
  end
end
