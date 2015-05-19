require 'loadshedding_status'
require 'eskom_http_connection'

class EskomLoadshedStatusProvider
  def self.get_status
    EskomLoadshedStatusProvider.new(EskomHTTPConnection).get_status
  end

  def initialize(connection)
    @connection = connection
  end

  def get_status
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

  def get_eskom_status
    begin
      @connection.get_status_result
    rescue
      ""
    end
  end

end
