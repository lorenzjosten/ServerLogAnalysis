module ScannerModule
  module ScannerConstants
    HTTP_METH = Regexp.new('(?<html_meth>GET|POST|HEAD|PUT|PATCH|DELETE|TRACE|OPTIONS|CONNECT)')
    HTTP_STAT = Regexp.new('(?<html_stat>'+Rack::Utils::HTTP_STATUS_CODES.keys.inject(nil.to_s) {|str,code| str+code.to_s+"|"}.chop+')')
    MATCH = {
      :request=>Regexp.new('(?<=Started)\s'+HTTP_METH.source+'(?=\s)'), # HTTP-requests
      :dragon=>Regexp.new('(?<dragonfly>DRAGONFLY(?=\:\s))'), # Call to media server
      :url=>Regexp.new('(?<=Started).*\"(?<URL>(?:\/\S*)+)\"\s(?=for)'), # requested URL
      :access_time=>Regexp.new('(?<=at)\s(?<datetime>\d{4}-\d{2}-\d{2}\s\d{2}:\d{2}:\d{2})\s(?:\W*\d*)+(?=$)'), # time of request
      :stat=>Regexp.new('(?<=Completed)\s'+HTTP_STAT.source+'(?=\s)'), # sent HTTP-Status
      :respT=>Regexp.new('(?<=Completed)(?:\w|\s)*in\s(?<resp_t>\d+)(?=ms)') # server response time
    }
    LOGLINE = {
      :thread=>Regexp.new('^.*\#(?<thread>\d+)(?=.*\])'), # active thread ID
      :body=>Regexp.new('^.*(?<=\s:\s)\s*(?<body>.*\s)(?=$)') # body of the log line
    }
    URL_FILTER = [
      %r{feed(?=$)},
      %r{feed\.atom(?=$)},
      %r{/blog(?=$)},
      %r{/blog\.atom(?=$)},
      %r{/blog\?page=(?=\d)},
      %r{wp-login.php(?=$)},
      %r{(?<=^)/de(?=$)},
      %r{(?<=^)/(?=$)},
      %r{(?<=^)/en(?=$)},
      %r{/admin/},
      %r{/admin(?=$)}
    ] # blacklist urls
    REQUEST_FILTER = [
      %r{GET}
    ] # whitelist http request
    STAT_FILTER = [
      %r{200},
    ] # whitelist response stats
  end
end
