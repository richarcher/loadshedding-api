class Schedule
  def initialize(periods)
    @periods = periods
  end

  def is_it_me_now?(zone)
    @periods.any? { |p| p.is_this_me_now?(zone) }
  end
end
