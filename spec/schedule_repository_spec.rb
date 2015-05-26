require('spec_helper')
require('lib/schedule_repository')

describe "schedule repository" do

  it "returns a schedule_period object" do
    expect(ScheduleRepository.all.first).to be_a_kind_of(SchedulePeriod)
  end

  it "calls SchedulePeriod with the correct schedules" do
    expect(ScheduleRepository).to receive(:file_data).and_return(json_schedules_stub)
    expect(ScheduleRepository.all.size).to eq(3)
  end

  def json_schedules_stub
    '
    {
      "schedule" : [
        {
          "zone" : "1",
          "times" : [
            { "start" : "", "end" : "" },
            { "start" : "", "end" : "" }
          ]
        },
        {
          "zone" : "Macassar",
          "times" : [
            { "start" : "", "end" : "" }
          ]
        }
      ]
    }
    '
  end

end
