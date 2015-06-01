
#require './lib/schedule'

#class ScheduleRepository

  #def self.for_status(status)
    #stages = CapeTownSchedulePDF.stages
    #schedules = CapeTownSchedulePDFParser.new(stages)
    #if status == LoadShedding.stage1
      #schedules.stage1
    #end

    #Schedule.new([])
  #end

#end





#DAYS OF THE MONTH
#1st 2nd 3rd 4th 5th 6th 7th 8th 9th 10th 11th 12th 13th 14th 15th 16th
#17th 18th 19th 20th 21st 22nd 23rd 24th 25th 26th 27th 28th 29th 30th 31st
#TIME FROM TIME TO
#0:00 2:30 1 13 9 5 2 14 10 6 3 15 11 7 4 16 12 8
#2:00 4:30 2 14 10 6 3 15 11 7 4 16 12 8 5 1 13 9
#4:00 6:30 3 15 11 7 4 16 12 8 5 1 13 9 6 2 14 10
#6:00 8:30 4 16 12 8 5 1 13 9 6 2 14 10 7 3 15 11
#8:00 10:30 5 1 13 9 6 2 14 10 7 3 15 11 8 4 16 12
#10:00 12:30 6 2 14 10 7 3 15 11 8 4 16 12 9 5 1 13
#12:00 14:30 7 3 15 11 8 4 16 12 9 5 1 13 10 6 2 14
#14:00 16:30 8 4 16 12 9 5 1 13 10 6 2 14 11 7 3 15
#16:00 18:30 9 5 1 13 10 6 2 14 11 7 3 15 12 8 4 16
#18:00 20:30 10 6 2 14 11 7 3 15 12 8 4 16 13 9 5 1
#20:00 22:30 11 7 3 15 12 8 4 16 13 9 5 1 14 10 6 2
#22:00 0:30 12 8 4 16 13 9 5 1 14 10 6 2 15 11 7 3

#[ [1,17] [{start: 0:00, end: 2:30, zones: [1]}
#]

# Month
# period.set(day_of_the_month)
# period.set(start_time)
# period.set(end_time)
# period.add_zone
#
# Header = [[1,17]. [2,18]]
# Period.new(zone, day_of_month, start_time, end_time)
#
# first row -> create date
# second row -> day.add( col val )
# 1st col -> 
#
#
#

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
