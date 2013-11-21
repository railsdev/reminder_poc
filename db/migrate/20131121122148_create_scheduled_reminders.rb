class CreateScheduledReminders < ActiveRecord::Migration
  def change
    create_table :scheduled_reminders do |t|
      t.integer :reminder_id
      t.datetime :run_at
      t.string :status

      t.timestamps
    end
  end
end
