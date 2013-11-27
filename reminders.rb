ScheduleReminder.destroy_all
Reminder.destroy_all
# Daily Reminders
#
Reminder.create(fq_type: 'Daily', fq_time: Time.now + 4.hours )

# Weekly Reminders
#
Reminder.create(fq_type: 'Weekly', fq_day: 4, fq_time: Time.now + 3.hours)

# Monthly Reminders
#
Reminder.create(fq_type: 'Monthly', fq_day: 15, fq_time: Time.now + 5.hours)

# Yearly Reminders
#
Reminder.create(fq_type: 'Yearly', fq_month: 6, fq_day: 20, fq_time: Time.now + 16.hours)

# Every X Hours reminders
#
Reminder.create(fq_type: 'Every X hours', interval: 5, start_time: Time.now + 3.hours )

# Every X days reminders
#
Reminder.create(fq_type: 'Every X days', interval: 2, fq_time: Time.now + 2.hours, start_time: Time.now + 2.days)

# Every X weeks reminders
#
Reminder.create(fq_type: 'Every X weeks', interval: 3, fq_day: 3, fq_time: Time.now + 5.hours, start_time: Time.now + 1.weeks)

# Every X months reminders
#
Reminder.create(fq_type: 'Every X months', interval: 2, fq_day: 17, fq_time: Time.now + 1.hours, start_time: Time.now + 1.months)

# Every X years reminders
#
Reminder.create(fq_type: 'Every X years', interval: 2, fq_day: 23, fq_month: 3, fq_time: Time.now + 8.hours, start_time: Time.now)
