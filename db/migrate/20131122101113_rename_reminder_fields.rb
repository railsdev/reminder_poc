class RenameReminderFields < ActiveRecord::Migration
  def change
    rename_column :reminders, :fq_interval, :interval
    rename_column :reminders, :fq_day_interval, :fq_day
    rename_column :reminders, :fq_monthly_interval, :fq_month
  end
end
