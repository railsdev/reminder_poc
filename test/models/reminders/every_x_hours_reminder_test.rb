require "test_helper"

class EveryXYearsReminderTest < ActiveSupport::TestCase

    def setup
      @reminder = Reminder.create( fq_type:    'Every X hours', 
                                   fq_time:    Time.now,
                                   start_time: Time.now,
                                   interval:   2 )
    end

    def test_daily_reminders_type
      assert_equal "Hourly", @reminder.fq_type
      assert_equal "scheduled", @reminder.status
    end

    def test_last_schedule_of_reminder
      assert_equal @reminder.last_schedule_on, @reminder.scheduled_reminders.order('run_at').last.run_at
    end

    def test_destroy
      reminder_id = @reminder.id
      @reminder.destroy
      assert_empty ScheduledReminder.where(reminder_id: reminder_id).to_a
    end


    # TODO: Bad way.. need to refactor
    def test_time_of_schedule_reminders
      @reminder.scheduled_reminders.each{|x| assert_equal x.run_at.hour, @reminder.fq_time.hour}
      @reminder.scheduled_reminders.each{|x| assert_equal x.run_at.min, @reminder.fq_time.min}
    end

    def test_different_of_time_between_scheduled_reminders
      @reminder.scheduled_reminders.order('run_at').to_a.each_cons(2).each{|a, b| assert_equal (b.run_at.hour - a.run_at.hour ), @reminder.interval }
    end


end
