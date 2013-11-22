class AddStatusFieldToReminders < ActiveRecord::Migration
  def change
    add_column :reminders, :status, :string, :default => 'unscheduled'
  end
end
