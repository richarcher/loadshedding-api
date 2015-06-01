require('json')

class ScheduleRepository
  def self.all
    array = []
    json = JSON.parse( file_data )['stage']
    json.each do |stage|
      stage["schedule"]["days"].each do |day|
        day["zones"].each do |zone|
          zone["times"].each do |time|
            array << SchedulePeriod.new(zone["name"], time["start"], time["end"], stage: stage["name"])
          end
        end
      end
    end
    array
  end

  private

  def self.file_data
    File.read('./lib/schedules.js')
  end
end