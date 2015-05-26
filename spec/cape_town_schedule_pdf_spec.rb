require 'spec_helper'
require './lib/cape_town_schedule_pdf'

describe 'CapeTownSchedulePDF' do
  describe '#stages' do
    it 'there are 4 stages' do
      stages = CapeTownSchedulePDF.stages
      expect(stages.size).to eq(4)
    end

    context 'stage 1' do
      it 'has a stage 1' do
        stages = CapeTownSchedulePDF.stages
        expect(stages['STAGE 1']).to_not eq(nil)
      end

      it 'has a 14 rows' do
        stages = CapeTownSchedulePDF.stages
        expect(stages['STAGE 1'].size).to eq(14)
      end
    end

    context 'stage 2' do
      it 'has a stage 2' do
        stages = CapeTownSchedulePDF.stages
        expect(stages['STAGE 2']).to_not eq(nil)
      end

      it 'has a 14 rows' do
        stages = CapeTownSchedulePDF.stages
        expect(stages['STAGE 2'].size).to eq(14)
      end
    end

    context 'stage 3A' do
      it 'has a stage 3A' do
        stages = CapeTownSchedulePDF.stages
        expect(stages['STAGE 3A']).to_not eq(nil)
      end

      it 'has a 14 rows' do
        stages = CapeTownSchedulePDF.stages
        expect(stages['STAGE 3A'].size).to eq(14)
      end
    end

    context 'stage 3B' do
      it 'has a stage 3B' do
        stages = CapeTownSchedulePDF.stages
        expect(stages['STAGE 3B']).to_not eq(nil)
      end

      it 'has a 14 rows' do
        stages = CapeTownSchedulePDF.stages
        expect(stages['STAGE 3B'].size).to eq(14)
      end
    end

  end
end

