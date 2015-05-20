class Schedule
  def initialize(periods)
    @periods = periods
  end

  def is_it_me_now?(zone)
    @periods.any? { |p| p.zone == zone && p.end_time > Time.now && p.start_time < Time.now }
  end
end
