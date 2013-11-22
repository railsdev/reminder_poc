# == Schema Information
#
# Table name: reminders
#
#  id                        :integer          not null, primary key
#  user_id                   :integer
#  parent_id                 :integer
#  name                      :string(255)
#  fq_type                   :string(255)
#  interval                  :integer
#  fq_day                    :integer
#  fq_month                  :integer
#  fq_time                   :datetime
#  start_time                :datetime
#  scheduled_reminders_count :integer
#  status                    :string(255)      default("unscheduled")
#  created_at                :datetime
#  updated_at                :datetime
#

class Reminder < ActiveRecord::Base
  include IceCube
  include ActsAsTree

  acts_at_tree order: 'name'

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
      #

      start_time = Time.now
    end
    
    schedule = Schedule.new(start_time) do |s|
      s.add_recurrence_rule(occurrunce_rule) 
    end 

    occurrences = schedule.occurrences(Time.now + 1.month )

    if occurrences.size > 0
      # Create scheduled occurrences
      #
    
      line_up_all_reminders(occurrences)
      update_reminder_count(scheduled_occurrences.count)
      update_status('scheduled')

    end
  end

  def occurrunce_rule
    rule = interval.nil? ? Rule.send(fq_type.downcase.to_sym) : Rule.send(fq_type.downcase.to_sym, interval)

    # Add day of week in case of weekly
    rule = rule.day_of_week(fq_day) if fq_type == 'Weekly'

    # Add day of month in case of monthly
    rule = rule.day_of_month(fq_day) if fq_type == 'Monthly'

    # Add month of year and day of month in case of yearly
    rule = rule.month_of_year(fq_month).day_of_month(fq_day) if fq_type == 'Yearly'

    # Add time to the final rule
    rule.hour_of_day(fq_time.hour).minute_of_hour(fq_time.minute) unless fq_type == 'Hourly' # Because time in hourly case, is handled by start_time

    return rule
  end

  def line_up_all_reminders(occurrences)
    occurrences.each do |o_dtime| 
      sr = {run_at: o_dtime, status: 'pending'}
      scheduled_occurrences.create(sr)
    end
    #return scheduled_occurrences
  end

  def update_reminder_count(r_count)
    update_column(:scheduled_reminders_count, r_count)
  end

  def update_status(status_str)
    update_column(:status, status_str)
  end

  def having_natural_interval
    ['Daily', 'Weekly', 'Monthly', 'Yearly'].include?(fq_type)
  end

  def having_manual_interval
    manual_intervals = {'hourly'  => 'Every X hours', 
                        'daily'   => 'Every X days', 
                        'weekly'  => 'Every X weeks', 
                        'monthly' => 'Every X Months', 
                        'yearly'  => 'Every X Year'}
    fq_type = manual_intervals.key(fq_type)
    return manual_intervals.keys.include?(fq_type)
  end

end
