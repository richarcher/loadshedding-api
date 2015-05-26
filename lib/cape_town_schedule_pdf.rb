require 'pdf-reader'

class CapeTownSchedulePDF
  def self.stages
    reader = PDF::Reader.new('./lib/data/CPT_Schedule.pdf')
    page = reader.page(1)
    text = page.text

    stages = {}
    current_stage = []
    text.each_line do |line|
      clean_line = line.strip
      if clean_line=~/STAGE/
        current_stage = []
        stages[clean_line] = current_stage
      else
        current_stage << clean_line if valid_row?(clean_line)
      end
    end
    stages
  end

  private

  def self.valid_row?(row)
    row.size > 0 && (row[0].to_i > 0 || row[0] == '0')
  end
end
