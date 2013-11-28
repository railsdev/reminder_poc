# == Schema Information
#
# Table name: reminders
#
#  id               :integer          not null, primary key
#  user_id          :integer
#  name             :string(255)
#  fq_type          :string(255)
#  interval         :integer
#  fq_month         :integer
#  fq_time          :datetime
#  created_at       :datetime
#  updated_at       :datetime
#  parent_id        :integer
#  status           :string(255)      default("unscheduled")
#  fq_day           :integer
#  start_time       :datetime
#  last_schedule_on :datetime
#

class Reminder < ActiveRecord::Base
  include IceCube
  include ActsAsTree

  acts_as_tree order: 'name'

  has_many :scheduled_reminders, dependent: :destroy

  after_save {
    clean_all_scheduled_reminders
    set_up_new_reminder_schedules
  }

  def as_json(options={})
    self.attributes.symbolize_keys.extract!(:user_id, :name, :fq_type, :interval, :fq_month, :fq_time, :fq_day, :status, :start_time)
  end

  private

  def clean_all_scheduled_reminders
    scheduled_reminders.destroy_all unless scheduled_reminders.count.zero?
  end 

  def set_up_new_reminder_schedules

    if having_natural_interval
      # Generate IceCube Schedule      
      #

      self.start_time = Time.now
    else
      set_type_for_manual_interval
    end
    schedule = Schedule.new(start_time) do |s|
      s.add_recurrence_rule(occurrunce_rule) 
    end 
    occurrences = schedule.occurrences( start_time + 1.month ) if ['Hourly', 'Daily', 'Weekly'].include? self.fq_type
    occurrences = schedule.occurrences( start_time + 24.month ) if self.fq_type == 'Monthly'
    occurrences = schedule.occurrences( start_time + 10.year)   if self.fq_type == 'Yearly'

    if occurrences.size > 0
      # Create scheduled occurrences
      #

      line_up_all_reminders(occurrences)
      update_column(:last_schedule_on, scheduled_reminders.order(:run_at).last.run_at)
      update_status('scheduled')

    end
  end

  def occurrunce_rule
    rule = interval.nil? ? Rule.send(fq_type.downcase.to_sym) : Rule.send(fq_type.downcase.to_sym, interval)

    # Add day of week in case of weekly
    rule = rule.day(fq_day) if fq_type == 'Weekly'

    # Add day of month in case of monthly
    rule = rule.day_of_month(fq_day) if fq_type == 'Monthly'

    # Add month of year and day of month in case of yearly
    rule = rule.month_of_year(fq_month).day_of_month(fq_day) if fq_type == 'Yearly'

    # Add time to the final rule
    rule.hour_of_day(fq_time.hour).minute_of_hour(fq_time.min) unless fq_type == 'Hourly' # Because time in hourly case, is handled by start_time

    return rule
  end

  def line_up_all_reminders(occurrences)
    occurrences.each do |o_dtime| 
      sr = {run_at: o_dtime, status: 'pending'}
      scheduled_reminders.create(sr)
    end
    #return scheduled_occurrences
  end

  ### Deprecated!!!!
  def update_reminder_count(r_count)
    update_column(:scheduled_reminders_count, r_count)
  end

  def update_status(status_str)
    update_column(:status, status_str)
  end

  def having_natural_interval
    ['Daily', 'Weekly', 'Monthly', 'Yearly'].include?(fq_type)
  end

  def set_type_for_manual_interval
    manual_intervals = {'Hourly'  => 'Every X hours', 
                        'Daily'   => 'Every X days', 
                        'Weekly'  => 'Every X weeks', 
                        'Monthly' => 'Every X months', 
                        'Yearly'  => 'Every X years'}
    self.fq_type = manual_intervals.key(self.fq_type)
    #return manual_intervals.keys.include?(self.fq_type)
  end

end
