class SchedulePeriod
  attr_reader :zone, :start_time, :end_time

  def initialize(zone, start_time, end_time)
    @zone = zone
    @start_time = start_time
    @end_time = end_time
  end

  def is_this_me_now?(my_zone)
    my_zone == zone && end_time > Time.now && start_time < Time.now
  end
end
