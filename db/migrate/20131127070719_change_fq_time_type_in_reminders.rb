class ChangeFqTimeTypeInReminders < ActiveRecord::Migration
  def change
    Reminder.delete_all
    change_column :reminders, :fq_time, :datetime
  end
end
