require 'logger'

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
    puts "log?"
    if result != @last_result
      puts "log!"
      #FileUtils.mkdir_p("./log")
      puts "xx"
      logger = Logger.new("#{@log_prefix}_#{Time.now}.log")
      puts "yy"
      puts "log/#{@log_prefix}_#{Time.now}.log"
      puts "zz"
      logger.level = Logger::WARN
      logger.warn(result)
      logger.close
    end
    @last_result = result
  end
end
