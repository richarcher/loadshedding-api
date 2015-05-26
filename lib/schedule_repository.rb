require('json')

class ScheduleRepository
  def self.all
    array = []
    json = JSON.parse( file_data )['schedule']
    json.each do |schedule|
      schedule["times"].each do |time|
        array << SchedulePeriod.new(schedule["zone"], time["start"], time["end"])
      end
    end
    array
  end

  private

  def self.file_data
    File.read('./lib/schedules.js')
  end
end