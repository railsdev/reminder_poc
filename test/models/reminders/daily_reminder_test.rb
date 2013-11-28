require "test_helper"

class DailyReminderTest < ActiveSupport::TestCase

    def setup
      @reminder = Reminder.create( fq_type: 'Daily', fq_time: Time.now )
    end

    def test_daily_reminders_type
      assert_equal "Daily", @reminder.fq_type
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

    def test_count_of_scheduled_reminders
      assert_includes [30, 31], @reminder.scheduled_reminders.count
    end

    def test_different_of_time_between_scheduled_reminders
      faulty_scheduled_reminders = @reminder.scheduled_reminders.to_a.each_cons(2).select{|a, b| (b.run_at - a.run_at).to_i.seconds != 1.day.seconds }
      faulty_scheduled_reminders.must_be_empty
    end


end
