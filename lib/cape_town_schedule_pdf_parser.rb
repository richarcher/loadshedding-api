require 'csv'

class CapeTownSchedulePDFParser
  def self.to_day_date_hash(data)
    matrix = parse(data)

    hash = {}
    header = matrix.shift
    header.each_with_index do |date_list, idx|
      date_list.each do |date|
        hash[date] ||= []
        matrix.each do |row|
          hash[date] << row[idx]
        end
      end
    end

    hash
  end

  # RESULT: [ [1,17],[2,18],[3,19],...,[15,31],[16] ]
  #         [ {start_time: '', end_time: '', zones: '1'}, ...]
  #         [ {start_time: '', end_time: '', zones: '1'}, ...]
  def self.parse(data)
    matrix = []
    matrix << header_row(data.shift, data.shift)
    data_rows(matrix, data)
  end

  private

  def self.header_row(header_row1, header_row2)
    header1 = clean_header_row(header_row1)
    header2 = clean_header_row(header_row2)

    header_row = []
    header1.each_with_index do |h1, idx|
      col = [h1]
      col << header2[idx] unless header2[idx].nil?
      header_row << col
    end

    header_row
  end

  def self.clean_header_row(row)
    row.gsub(/st|nd|rd|th/, '').split(' ')
  end

  def self.data_rows(matrix, data)
    start_time = ''
    end_time = ''

    data.each do |data_row|
      row = data_row.gsub(', ', ',').split(' ')
      new_row = []

      row.each_with_index do |d, idx|
        start_time = d if idx == 0
        end_time = d if idx == 1
        if idx > 1
          col = { start_time: start_time, end_time: end_time, zones: d.split(',') }
          new_row << col
        end
      end
      matrix << new_row
    end
    matrix
  end
end
