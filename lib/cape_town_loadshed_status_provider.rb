require 'net/http'
require 'nokogiri'

require 'loadshedding_status'

class CapeTownLoadshedStatusProvider
  def self.get_status
    page = get_capetown_status_page
    loadshedding_status( from_page_status( page ))
  end

  private

  def self.loadshedding_status( status )
    return LoadsheddingStatus.none if status == 'LOADSHEDDING HAS BEEN SUSPENDED UNTIL FURTHER NOTICE'
    return LoadsheddingStatus.stage1 if status == 'LOADSHEDDING IS IN STAGE 1'
    return LoadsheddingStatus.none
  end

  def self.from_page_status( page )
    html_doc = Nokogiri::HTML( page )
    html_doc.css("table table table table .CityArticleTitle").text
  end

  def self.get_capetown_status_page
    begin
      res = Net::HTTP.start("www.capetown.gov.za", 80) { |http|
        http.get("/en/electricity/Pages/LoadShedding.aspx")
      }
      res.body
    rescue
      ""
    end
  end
end

