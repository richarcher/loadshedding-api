require './lib/eskom_loadshed_status_provider'
require './lib/eskom_http_connection'
require './lib/cape_town_loadshed_status_provider'
require './lib/cape_town_http_connection'
require './lib/logging_http_connection'

current_eskom = ''
current_cpt = ''
count = 0

eskom = EskomLoadshedStatusProvider.new(LoggingHTTPConnection.new(EskomHTTPConnection, 'eskom'))
cpt = CapeTownLoadshedStatusProvider.new(LoggingHTTPConnection.new(CapeTownHTTPConnection, 'capetown'))

while true do
  time = Time.now
  puts "is alive at #{time}" if count % 4 == 0

  eskom_status = eskom.get_status
  if eskom_status != current_eskom
    puts "#{time}: Eskom status has changed to #{eskom_status.stage}"
    current_eskom = eskom_status
  end

  cpt_status = cpt.get_status
  if cpt_status != current_cpt
    puts "#{time}: Cape Town status has changed to #{cpt_status.stage}"
    current_cpt = cpt_status
  end

  count = count + 1
  sleep 15 * 60 # 15 mins
end
