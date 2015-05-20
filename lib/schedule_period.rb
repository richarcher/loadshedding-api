class SchedulePeriod
  attr_reader :zone, :start_time, :end_time

  def initialize(zone, start_time, end_time)
    @zone = zone
    @start_time = start_time
    @end_time = end_time
  end

end
