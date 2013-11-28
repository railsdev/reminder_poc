require "test_helper"

class WeeklyReminderTest < ActiveSupport::TestCase

    def setup
      @reminder = Reminder.create( :fq_type => 'Weekly', :fq_day => 3, :fq_time => Time.now )
    end

    def test_daily_reminders_type
      assert_equal "Weekly", @reminder.fq_type
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
    def test_day_of_scheduled_reminders
      @reminder.scheduled_reminders.each{|x| assert_equal x.run_at.wday, @reminder.fq_day }
    end

    # TODO: Bad way.. need to refactor
    def test_time_of_schedule_reminders
      @reminder.scheduled_reminders.each{|x| assert_equal x.run_at.hour, @reminder.fq_time.hour}
      @reminder.scheduled_reminders.each{|x| assert_equal x.run_at.min, @reminder.fq_time.min}
    end

    def test_different_of_time_between_scheduled_reminders
      faulty_scheduled_reminders = @reminder.scheduled_reminders.to_a.each_cons(2).select{|a, b| (b.run_at - a.run_at).to_i.seconds != 1.week.seconds }
      faulty_scheduled_reminders.must_be_empty
    end


end
