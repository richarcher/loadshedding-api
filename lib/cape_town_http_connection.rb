require 'net/http'

class CapeTownHTTPConnection
  def self.get_status_result
    res = Net::HTTP.start("www.capetown.gov.za", 80) { |http|
      http.get("/en/electricity/Pages/LoadShedding.aspx")
    }
    res.body
  end
end
