require 'net/http'

class EskomHTTPConnection
  def self.get_status_result
    res = Net::HTTP.start("loadshedding.eskom.co.za", 80) { |http|
      http.get("/LoadShedding/GetStatus")
    }
    res.body
  end
end
