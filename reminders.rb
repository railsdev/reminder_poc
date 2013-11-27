ScheduledReminder.destroy_all
Reminder.destroy_all
# Daily Reminders
#
reminder = Reminder.create(fq_type: 'Daily', fq_time: Time.now + 4.hours )
puts "Daily: Created #{reminder.scheduled_reminders.count} reminders. Next reminder will run on #{reminder.scheduled_reminders.first.run_at}."

# Weekly Reminders
#
reminder = Reminder.create(fq_type: 'Weekly', fq_day: 4, fq_time: Time.now + 3.hours)
puts "Weekly: Created #{reminder.scheduled_reminders.count} reminders. Next reminder will run on #{reminder.scheduled_reminders.first.run_at}."

# Monthly Reminders
#
reminder = Reminder.create(fq_type: 'Monthly', fq_day: 15, fq_time: Time.now + 5.hours)
puts "Monthly: Created #{reminder.scheduled_reminders.count} reminders. Next reminder will run on #{reminder.scheduled_reminders.first.run_at}."

# Yearly Reminders
#
reminder = Reminder.create(fq_type: 'Yearly', fq_month: 6, fq_day: 20, fq_time: Time.now + 16.hours)
puts "Yearly: Created #{reminder.scheduled_reminders.count} reminders. Next reminder will run on #{reminder.scheduled_reminders.first.run_at}."

# Every X Hours reminders
#
reminder = Reminder.create(fq_type: 'Every X hours', interval: 5, start_time: Time.now + 3.hours )
puts "Every #{reminder.interval} Hours: Created #{reminder.scheduled_reminders.count} reminders. Next reminder will run on #{reminder.scheduled_reminders.first.run_at}."

# Every X days reminders
#
reminder = Reminder.create(fq_type: 'Every X days', interval: 2, fq_time: Time.now + 2.hours, start_time: Time.now + 2.days)
puts "Every #{reminder.interval} Days: Created #{reminder.scheduled_reminders.count} reminders. Next reminder will run on #{reminder.scheduled_reminders.first.run_at}."

# Every X weeks reminders
#
reminder = Reminder.create(fq_type: 'Every X weeks', interval: 3, fq_day: 3, fq_time: Time.now + 5.hours, start_time: Time.now + 1.weeks)
puts "Every #{reminder.interval} Weeks: Created #{reminder.scheduled_reminders.count} reminders. Next reminder will run on #{reminder.scheduled_reminders.first.run_at}."

# Every X months reminders
#
reminder = Reminder.create(fq_type: 'Every X months', interval: 2, fq_day: 17, fq_time: Time.now + 1.hours, start_time: Time.now + 1.months)
puts "Every #{reminder.interval} months: Created #{reminder.scheduled_reminders.count} reminders. Next reminder will run on #{reminder.scheduled_reminders.first.run_at}."

# Every X years reminders
#
reminder = Reminder.create(fq_type: 'Every X years', interval: 2, fq_day: 23, fq_month: 3, fq_time: Time.now + 8.hours, start_time: Time.now)
puts "Every #{reminder.interval} years: Created #{reminder.scheduled_reminders.count} reminders. Next reminder will run on #{reminder.scheduled_reminders.first.run_at}."
