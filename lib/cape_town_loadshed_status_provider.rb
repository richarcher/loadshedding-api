require 'nokogiri'

require './lib/loadshedding_status'
require './lib/cape_town_http_connection'

class CapeTownLoadshedStatusProvider
  def self.get_status
    CapeTownLoadshedStatusProvider.new(CapeTownHTTPConnection).get_status
  end

  def initialize(connection)
    @connection = connection
  end

  def get_status
    page = get_capetown_status_page
    loadshedding_status( from_page_status( page ))
  end

  private

  LOADSHEDDING_STATUSES = [
    { regex: /SUSPEND/, status: LoadsheddingStatus.none },
    { regex: /STAGE\s*1/i, status: LoadsheddingStatus.stage1 },
    { regex: /STAGE\s*2/i, status: LoadsheddingStatus.stage2 },
    { regex: /STAGE\s*3a/i, status: LoadsheddingStatus.stage3a },
    { regex: /STAGE\s*3b/i, status: LoadsheddingStatus.stage3b }
  ]

  def loadshedding_status( status )
    LOADSHEDDING_STATUSES.each do |map|
      return map[:status] if status =~ map[:regex]
    end
    return LoadsheddingStatus.none
  end

  def from_page_status( page )
    html_doc = Nokogiri::HTML( page )
    html_doc.css("table table table table .CityArticleTitle").text
  end

  def get_capetown_status_page
    begin
      @connection.get_status_result
    rescue
      ""
    end
  end
end

