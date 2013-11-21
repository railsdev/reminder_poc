# == Schema Information
#
# Table name: reminders
#
#  id                  :integer          not null, primary key
#  user_id             :integer
#  name                :string(255)
#  fq_type             :string(255)
#  fq_interval         :integer
#  fq_monthly_interval :integer
#  fq_time             :datetime
#  created_at          :datetime
#  updated_at          :datetime
#

class Reminder < ActiveRecord::Base
  include IceCube
  has_many :scheduled_reminders

  after_save {
    clean_all_scheduled_reminders
    set_up_new_reminder_schedules
  }

  private

  def clean_all_scheduled_reminders
    scheduled_reminders.destroy_all unless scheduled_reminders.count.zero?
  end 

  def set_up_new_reminder_schedules
    if having_natural_interval

      # Generate IceCube Schedule      
      schedule = Schedule.new(now = Time.now) do |s|
        s.add_recurrence_rule(occurrunce_rule) 
      end 
    elsif having_manual_interval
      # TODO: Manual Interval remaining
    end
  end

  def occurrunce_rule
    rule = Rule.send(fq_type.downcase.to_sym)
    rule = rule.day_of_week(fq_interval) if fq_type == 'Weekly'
    rule = rule.day_of_month(fq_interval) if fq_type == 'Monthly'
    rule = rule.month_of_year(fq_monthly_interval).day_of_month(fq_interval) if fq_type == 'Yearly'
    rule.hour_of_day(fq_time.hour).minute_of_hour(fq_time.minute)
    return rule
  end

  def having_natural_interval
    ['Daily', 'Weekly', 'Monthly', 'Yearly'].include?(fq_type)
  end

  def having_manual_interval
    ['Every X days', 'Every X weeks', 'Every X Months', 'Every X Year'].include?(fq_type)
  end


end
