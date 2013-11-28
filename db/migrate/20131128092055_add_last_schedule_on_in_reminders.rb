class AddLastScheduleOnInReminders < ActiveRecord::Migration
  def change
    add_column :reminders, :last_schedule_on, :datetime
    remove_column :reminders, :scheduled_reminders_count
  end
end
