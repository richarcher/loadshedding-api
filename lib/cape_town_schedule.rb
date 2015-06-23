require 'cape_town_schedule_pdf'
require 'cape_town_schedule_pdf_parser'
require 'schedule'
require 'schedule_period'

class CapeTownSchedule
  def self.for_date(date)
    day = date.mday

    periods = CapeTownSchedulePDF.stages.map do |stage, data|
      stage_data = CapeTownSchedulePDFParser.to_day_date_hash(data)

      stage_data[day.to_s].map do |period|
        period[:zones].map do |zone|
          SchedulePeriod.new(zone, as_date(period[:start_time], date), as_date(period[:end_time], date), stage)
        end.flatten
      end
    end.flatten

    Schedule.new(periods)
  end

  private

  def self.as_date(time, date)
    hours, minutes = time.split(':')
    Time.new( date.year, date.month, date.day, hours.to_i, minutes.to_i)
  end


end
