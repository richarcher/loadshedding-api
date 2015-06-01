#require 'spec_helper'
#require './lib/loadshedding_status'
#require './lib/schedule_repository'

#describe 'Schedule' do
  #describe '.for_status' do
    #it 'returns an empty schedule for no load shedding' do
      #status = LoadsheddingStatus.none
      #schedule = ScheduleRepository.for_status(status)
      #expect(schedule.periods.size).to eq(0)
    #end

    #it 'returns the zone 1 schedule' do
      ## given the pdf

    #end
  #end


require('spec_helper')
require('lib/schedule_repository')

describe "schedule repository" do

  before :each do
    allow(ScheduleRepository).to receive(:file_data) { json_schedules_stub }
  end

  it "returns a schedule_period object" do
    expect(ScheduleRepository.all.first).to be_a_kind_of(SchedulePeriod)
  end

  it "calls SchedulePeriod with the correct schedules" do
    expect(ScheduleRepository.all.size).to eq(4)
  end

  it "expects the correct zone from for the first SchedulePeriod" do
    expect(ScheduleRepository.all.first.zone).to eq("1")
  end

  it "expects the correct start time for the first SchedulePeriod" do
    expect(ScheduleRepository.all.first.start_time).to eq("00:00:00")
  end

  it "expects the correct end time for the first SchedulePeriod" do
    expect(ScheduleRepository.all.first.end_time).to eq("02:30:00")
  end

  it "expects the correct end time for the first SchedulePeriod" do
    expect(ScheduleRepository.all.first.stage).to eq("1")
  end



  def json_schedules_stub
    '
    {
      "stage" : [
        {
          "name" : "1",
          "schedule" : {
            "days" : [
              {
                "zones" : [
                  {
                    "name" : "1",
                    "times" : [
                      { "start" : "00:00:00", "end" : "02:30:00" }
                    ]
                  },
                  {
                    "name" : "2",
                    "times" : [
                      { "start" : "02:00:00", "end" : "04:30:00" }
                    ]
                  }
                ]
              }
            ]
          }
        },
        {
          "name" : "2",
          "schedule" : {
            "days" : [
              {
                "zones" : [
                  {
                    "name" : "1",
                    "times" : [
                      { "start" : "00:00:00", "end" : "02:30:00" },
                      { "start" : "16:00:00", "end" : "18:30:00" }
                    ]
                  }
                ]
              }
            ]
          }
        }
      ]
    }
    '
  end

end
