require 'spec_helper'
require './lib/loadshedding_status'
require './lib/schedule'
require './lib/schedule_period'

describe 'Schedule' do
  describe '.is_it_me_now?' do
    it 'is false if no periods for the schedule' do
      schedule = Schedule.new([])
      expect(schedule.is_it_me_now?(10)).to eq(false)
    end

    it 'is true if there is a period overlapping now for the zone' do
      schedule = Schedule.new([SchedulePeriod.new(10, Time.now - 10, Time.now + 10)])
      expect(schedule.is_it_me_now?(10)).to eq(true)
    end

    it 'is false if there is a period overlapping now for a different zone' do
      schedule = Schedule.new([SchedulePeriod.new(9, Time.now - 10, Time.now + 10)])
      expect(schedule.is_it_me_now?(10)).to eq(false)
    end

    it 'is false if the period ends before now for this zone' do
      schedule = Schedule.new([SchedulePeriod.new(10, Time.now - 20, Time.now - 10)])
      expect(schedule.is_it_me_now?(10)).to eq(false)
    end

    it 'is false if the period starts after now for this zone' do
      schedule = Schedule.new([SchedulePeriod.new(10, Time.now + 10, Time.now + 20)])
      expect(schedule.is_it_me_now?(10)).to eq(false)
    end
  end
end
