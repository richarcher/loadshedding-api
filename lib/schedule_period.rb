class SchedulePeriod
  attr_reader :zone, :start_time, :end_time, :stage

  def initialize(zone, start_time, end_time, stage: nil)
    @zone = zone
    @start_time = start_time
    @end_time = end_time
    @stage = stage
  end

end
