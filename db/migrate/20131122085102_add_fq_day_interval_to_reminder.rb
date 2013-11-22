class AddFqDayIntervalToReminder < ActiveRecord::Migration
  def change
    add_column :reminders, :fq_day_interval, :integer
  end
end
