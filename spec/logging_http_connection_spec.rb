require 'spec_helper'
require 'lib/logging_http_connection'

describe 'LoggingHTTPConnection' do

  before :each do
    FileUtils.rm Dir.glob('log/provider_*')
  end
  after :each do
    FileUtils.rm Dir.glob('log/provider_*')
  end

  it 'calls the initialised connection' do
    conn = double('Connection')
    expect(conn).to receive(:get_status_result)
    LoggingHTTPConnection.new(conn, 'provider').get_status_result
  end

  it 'logs to the file prefix' do
    conn = double('Connection')
    expect(conn).to receive(:get_status_result).and_return("some text")
    LoggingHTTPConnection.new(conn, 'provider').get_status_result

    expect(Dir.glob('log/provider_*.log').size).to eq(1)
  end

  it 'does not log if there is no change' do
    conn = double('Connection')
    expect(conn).to receive(:get_status_result).and_return("some text")
    log_conn = LoggingHTTPConnection.new(conn, 'provider')
    log_conn.get_status_result

    expect(conn).to receive(:get_status_result).and_return("some text")
    log_conn.get_status_result

    expect(Dir.glob('log/provider_*.log').size).to eq(1)
  end

  it 'does log if there is a change' do
    conn = double('Connection')
    expect(conn).to receive(:get_status_result).and_return("some text")
    log_conn = LoggingHTTPConnection.new(conn, 'provider')
    log_conn.get_status_result

    time = Time.now + 1
    expect(Time).to receive(:now).exactly(3).times.and_return(time)
    expect(conn).to receive(:get_status_result).and_return("some other text")
    log_conn.get_status_result

    expect(Dir.glob('log/provider_*.log').size).to eq(2)
  end
end
