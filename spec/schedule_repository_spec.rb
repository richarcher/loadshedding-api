require 'spec_helper'
require './lib/loadshedding_status'
require './lib/schedule_repository'

describe 'Schedule' do
  describe '.for_status' do
    it 'returns an empty schedule for no load shedding' do
      status = LoadsheddingStatus.none
      schedule = ScheduleRepository.for_status(status)
      expect(schedule.periods.size).to eq(0)
    end

    it 'returns the zone 1 schedule' do
      # given the pdf

    end
  end
end
