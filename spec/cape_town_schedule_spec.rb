require 'spec_helper'
require './lib/cape_town_schedule'

describe 'CapeTownSchedule' do
  describe '.for_date' do
    describe 'stages' do
      it 'has 4 stages' do
        schedule = CapeTownSchedule.for_date(Date.new(2015, 3, 1))
        stages = schedule.periods.uniq { |s| s.stage }
        expect(stages.size).to eq(4)
      end

      it 'has stage 1' do
        schedule = CapeTownSchedule.for_date(Date.new(2015, 3, 1))
        stages = schedule.periods.uniq { |s| s.stage }
        expect(stages[0].stage).to eq('STAGE 1')
      end

      it 'has stage 2' do
        schedule = CapeTownSchedule.for_date(Date.new(2015, 3, 1))
        stages = schedule.periods.uniq { |s| s.stage }
        expect(stages[1].stage).to eq('STAGE 2')
      end

      it 'has stage 3a' do
        schedule = CapeTownSchedule.for_date(Date.new(2015, 3, 1))
        stages = schedule.periods.uniq { |s| s.stage }
        expect(stages[2].stage).to eq('STAGE 3A')
      end

      it 'has stage 3b' do
        schedule = CapeTownSchedule.for_date(Date.new(2015, 3, 1))
        stages = schedule.periods.uniq { |s| s.stage }
        expect(stages[3].stage).to eq('STAGE 3B')
      end
    end

    describe 'zones' do
      it 'has 16 zones' do
        schedule = CapeTownSchedule.for_date(Date.new(2015, 3, 1))
        zone_ids = schedule.periods.map { |z| z.zone }.flatten.uniq
        expect(zone_ids.size).to eq(16)
      end

      it 'has 12 zones in stage1' do
        schedule = CapeTownSchedule.for_date(Date.new(2015, 3, 1))
        stage1 = schedule.periods.select { |s| s.stage == 'STAGE 1' }
        zone_ids = stage1.map { |z| z.zone }.flatten.uniq
        expect(zone_ids.size).to eq(12)
      end
    end
  end
end
