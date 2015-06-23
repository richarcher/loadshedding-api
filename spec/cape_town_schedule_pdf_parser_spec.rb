require 'spec_helper'
require './lib/cape_town_schedule_pdf'
require './lib/cape_town_schedule_pdf_parser'

describe 'CapeTownSchedulePDFParser' do
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



    it 'the second row, first col is' do
      row = CapeTownSchedulePDFParser.parse(@stages['STAGE 1'])[1]
      expect(row[0]).to eq({start_time: '0:00', end_time: '2:30', zones: '1'})
    end

    it 'the second row, last col is' do
      row = CapeTownSchedulePDFParser.parse(@stages['STAGE 1'])[1]
      expect(row[15]).to eq({start_time: '0:00', end_time: '2:30', zones: '8'})
    end

    it 'the last row, first col is' do
      row = CapeTownSchedulePDFParser.parse(@stages['STAGE 1'])[12]
      expect(row[0]).to eq({start_time: '22:00', end_time: '0:30', zones: '12'})
    end

    it 'the last row, last col is' do
      row = CapeTownSchedulePDFParser.parse(@stages['STAGE 1'])[12]
      expect(row[15]).to eq({start_time: '22:00', end_time: '0:30', zones: '3'})
    end
  end
end


