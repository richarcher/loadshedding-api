require 'spec_helper'
require './lib/cape_town_schedule'

describe 'CapeTownSchedule' do
  describe '.today' do
    describe 'stages' do
      it 'has 4 stages' do
        schedule = CapeTownSchedule.today
        stages = schedule.uniq { |s| s.stage }
        expect(stages.size).to eq(4)
      end
      it 'has stage 1' do
        schedule = CapeTownSchedule.today
        stages = schedule.uniq { |s| s.stage }
        expect(stages[0].stage).to eq('STAGE 1')
      end
      it 'has stage 2' do
        schedule = CapeTownSchedule.today
        stages = schedule.uniq { |s| s.stage }
        expect(stages[1].stage).to eq('STAGE 2')
      end
      it 'has stage 3a' do
        schedule = CapeTownSchedule.today
        stages = schedule.uniq { |s| s.stage }
        expect(stages[2].stage).to eq('STAGE 3A')
      end
      it 'has stage 3b' do
        schedule = CapeTownSchedule.today
        stages = schedule.uniq { |s| s.stage }
        expect(stages[3].stage).to eq('STAGE 3B')
      end
    end

    describe 'zones' do
      it 'has 16 zones' do
        pending
        schedule = CapeTownSchedule.today
        zones = schedule.uniq { |s| s.zone }
        expect(zones.size).to eq(16)
      end
    end
  end
end
