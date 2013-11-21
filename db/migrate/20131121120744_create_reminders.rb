class CreateReminders < ActiveRecord::Migration
  def change
    create_table :reminders do |t|
      t.integer :user_id
      t.string :name
      t.string :fq_type
      t.integer :fq_interval
      t.integer :fq_monthly_interval
      t.datetime :fq_time

      t.timestamps
    end
  end
end
