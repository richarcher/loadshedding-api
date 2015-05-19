require 'logger'
require 'fileutils'

class LoggingHTTPConnection

  def initialize(connection, log_prefix)
    @connection = connection
    @log_prefix = log_prefix
  end

  def get_status_result
    result = @connection.get_status_result
    log_result(result)
    result
  end

  private

  def log_result(result)
    if result != @last_result
      FileUtils::mkdir_p("log")
      logger = Logger.new("log/#{@log_prefix}_#{Time.now}.log")
      logger.level = Logger::WARN
      logger.warn(result)
      logger.close
    end
    @last_result = result
  end
end
