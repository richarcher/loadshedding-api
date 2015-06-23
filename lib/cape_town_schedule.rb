require 'cape_town_schedule_pdf'
require 'schedule_period'

class CapeTownSchedule
  def self.today
    CapeTownSchedulePDF.stages.map do |stage, data|
      #d = CapeTownSchedulePDFParser.parse_pdf(data)
      #d.each do |day, time_range, zones|

      #end

      SchedulePeriod.new('-1', Time.now, Time.now, stage)
    end
  end


end
