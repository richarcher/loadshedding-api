require 'spec_helper'
require './lib/cape_town_schedule_pdf'
require './lib/cape_town_schedule_pdf_parser'

describe 'CapeTownSchedulePDFParser' do
  describe '.to_day_date_hash' do
    before :each do
      @stages = CapeTownSchedulePDF.stages
    end

    it 'has 31 days in the month' do
      months = CapeTownSchedulePDFParser.to_day_date_hash(@stages['STAGE 1'])
      expect(months.keys.size).to eq(31)
    end

    it 'has 12 periods per day in stage 1' do
      months = CapeTownSchedulePDFParser.to_day_date_hash(@stages['STAGE 1'])
      expect(months['1'].size).to eq(12)
    end

    it 'has day 1 and day 16 the same' do
      months = CapeTownSchedulePDFParser.to_day_date_hash(@stages['STAGE 1'])
      expect(months['1']).to eq(months['17'])
    end
  end

  describe '#stages' do
    before :each do
      @stages = CapeTownSchedulePDF.stages
    end
    it 'there are 16 columns' do
      cols = CapeTownSchedulePDFParser.parse(@stages['STAGE 1'])[0]
      expect(cols.size).to eq(16)
    end
    it 'the first column is' do
      cols = CapeTownSchedulePDFParser.parse(@stages['STAGE 1'])[0]
      expect(cols[0]).to eq(["1","17"])
    end
    it 'the last column is' do
      cols = CapeTownSchedulePDFParser.parse(@stages['STAGE 1'])[0]
      expect(cols[15]).to eq(["16"])
    end


    context 'stage 1' do
      it 'the second row, first col is' do
        row = CapeTownSchedulePDFParser.parse(@stages['STAGE 1'])[1]
        expect(row[0]).to eq({start_time: '0:00', end_time: '2:30', zones: ['1']})
      end

      it 'the second row, last col is' do
        row = CapeTownSchedulePDFParser.parse(@stages['STAGE 1'])[1]
        expect(row[15]).to eq({start_time: '0:00', end_time: '2:30', zones: ['8']})
      end

      it 'the last row, first col is' do
        row = CapeTownSchedulePDFParser.parse(@stages['STAGE 1'])[12]
        expect(row[0]).to eq({start_time: '22:00', end_time: '0:30', zones: ['12']})
      end

      it 'the last row, last col is' do
        row = CapeTownSchedulePDFParser.parse(@stages['STAGE 1'])[12]
        expect(row[15]).to eq({start_time: '22:00', end_time: '0:30', zones: ['3']})
      end
    end

    context 'stage 2' do
      it 'the second row, first col is' do
        row = CapeTownSchedulePDFParser.parse(@stages['STAGE 2'])[1]
        expect(row[0]).to eq({start_time: '0:00', end_time: '2:30', zones: ['1','9']})
      end
    end

    context 'stage 3A' do
      it 'the second row, first col is' do
        row = CapeTownSchedulePDFParser.parse(@stages['STAGE 3A'])[12]
        expect(row[0]).to eq({start_time: '22:00', end_time: '0:30', zones: ['12','4','8']})
      end
    end

    context 'stage 3B' do
      it 'the second row, first col is' do
        row = CapeTownSchedulePDFParser.parse(@stages['STAGE 3B'])[12]
        expect(row[15]).to eq({start_time: '22:00', end_time: '0:30', zones: ['15','7','11','3']})
      end
    end

  end
end


