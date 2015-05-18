require 'net/http'
require 'loadshedding_status'

class EskomLoadshedStatusProvider
  def self.get_status
    status = get_eskom_status
    if LOADSHED_MAPPING[status].nil?
      return LoadsheddingStatus.none
    end
    return LOADSHED_MAPPING[status]
  end

  private

  LOADSHED_MAPPING = {
    "1" => LoadsheddingStatus.none,
    "2" => LoadsheddingStatus.stage1,
    "3" => LoadsheddingStatus.stage2,
    "4" => LoadsheddingStatus.stage3a,
    "5" => LoadsheddingStatus.stage3b,
  }

  def self.get_eskom_status
    begin
      res = Net::HTTP.start("loadshedding.eskom.co.za", 80) { |http|
        http.get("/LoadShedding/GetStatus")
      }
      res.body
    rescue
      ""
    end
  end
end
