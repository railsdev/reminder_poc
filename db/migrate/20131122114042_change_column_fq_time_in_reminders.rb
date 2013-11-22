class ChangeColumnFqTimeInReminders < ActiveRecord::Migration
  def change
    change_column :reminders, :fq_time, :time
  end
end
