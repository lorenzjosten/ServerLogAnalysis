module ScannerModule
  module ScannerConstants
    HTTP_METH = Regexp.new('(?<html_meth>GET|POST|HEAD|PUT|PATCH|DELETE|TRACE|OPTIONS|CONNECT)')
    HTTP_STAT = Regexp.new('(?<html_stat>'+Rack::Utils::HTTP_STATUS_CODES.keys.inject(nil.to_s) {|str,code| str+code.to_s+"|"}.chop+')')
    MATCH = {
      :request=>Regexp.new('(?<=Started)\s'+HTTP_METH.source+'(?=\s)'), # Art des HTTP-requests
      :dragon=>Regexp.new('(?<dragonfly>DRAGONFLY(?=\:\s))'), # Call to media server
      :url=>Regexp.new('(?<=Started).*\s\"(?<URL>(?:\/\S*)+)(?=\"\sfor)'), # Angefragte URL
      :access_time=>Regexp.new('(?<=at)\s(?<datetime>\d{4}-\d{2}-\d{2}\s\d{2}:\d{2}:\d{2})\s(?:\W*\d*)+(?=$)'), # Datum und Zeit des req
      :stat=>Regexp.new('(?<=Completed)\s'+HTTP_STAT.source+'(?=\s)'), # gesendeter HTTP-Status
      :respT=>Regexp.new('(?<=Completed)(?:\w|\s)*in\s(?<resp_t>\d+)(?=ms)') # benötigte Antwortzeit
    }
    LOGLINE = {
      :thread=>Regexp.new('^.*\#(?<thread>\d+)(?=.*\])'), # active thread ID
      :body=>Regexp.new('^.*(?<=\s:\s)\s*(?<body>.*\s)(?=$)') # body of the log line
    }
  end
end
