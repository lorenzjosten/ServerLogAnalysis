#Filescanner stellt eine Methode zum Scannen eines Files auf gegebene Schlüsselwörter bereit

module LogFileScanner

  HTML_METH = Regexp.new('(?<html_meth>GET|POST|HEAD|PUT|PATCH|DELETE|TRACE|OPTIONS|CONNECT)')
  HTML_STAT = Regexp.new('(?<html_stat>10\d|2\d\d|30\d|4\d\d|5\d\d)')
  HEAD = {#:type=>Regexp.new('(?<type>^\S)(=?, \[)'), # typically I=Info, F=Fatal
          #:hdate=>Regexp.new('^.*(?<hdate>\d{4}-\d{2}-\d{2})(?=.*\])'), # server date yyyy-mm-dd
          #:htime=>Regexp.new('^.*(?<htime>\d{2}:\d{2}:\d{2}.\d{6})(?=.*\])'), # server time hh-mm-ss
          :thread=>Regexp.new('^.*\#(?<thread>\d+)(?=.*\])'), # active thread ID
          #:desc=>Regexp.new('^.*(?<=\])\s*(?<desc>.*)(?=\s\:\s+)'), # description of log
          :body=>Regexp.new('^.*(?<=\s:\s)\s*(?<body>.*\s)(?=$)') # body of the log line
         }
  BODY = {:request=>Regexp.new('(?<=Started)\s'+HTML_METH.source+'(?=\s)'), # Art des HTTP-requests
          :dragon=>Regexp.new('(?<dragonfly>DRAGONFLY(?=\:\s))'),
          :url=>Regexp.new('(?<=Started).*\s\"(?<URL>(?:\/\S*)+)(?=\"\sfor)'), # Angefragte URL
          #:ip=>Regexp.new('(?<=Started).*for\s(?<IP>\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})(?=\sat)'), # IP des Clients
          :access_time=>Regexp.new('(?<=at)\s(?<datetime>\d{4}-\d{2}-\d{2}\s\d{2}:\d{2}:\d{2})\s(?:\W*\d*)+(?=$)'), # Datum und Zeit des req
          :stat=>Regexp.new('(?<=Completed)\s'+HTML_STAT.source+'(?=\s)'), # gesendeter HTTP-Status
          :respT=>Regexp.new('(?<=Completed)(?:\w|\s)*in\s(?<resp_t>\d+)(?=ms)') # benötigte Antwortzeit
          }

  # :scan startet den Scan des Files filename
  # :scan splittet Eingabedatei mit Hilfe von Schlüsselwörtern aus dem Hash $LOG in einzelne Thread-Logs auf
  # und sucht in vollständigen Requests nach Schlüsselwörtern aus dem Hash $BODY.
  # Wird ein keyword gefunden, füge das match dem Ausgabearray $matches hinzu
  #
  # @c_line gerade einglesene Zeile
  # @c_log Hash, der die in $c_line zu $LOG gematchten Schlüsselwörter speichert
  # @c_match Hash, der zu keywords gematchte Inhalte kapselt
  # @log Hash, der zu jedem Thread Logs speichert
  # @matches Speichert alle gefundenen matches

  def scan(input)

    c_line = ''
    c_log = {}
    c_match = {}
    c_thread = nil
    log = {}
    matches = []

    input.each_line do |c_line|

      # clear log-content of last iteration
      c_log.clear
      # scan c_line for any of HEAD's regexpressions, save matches to c_log
      HEAD.each_pair {|key, regexp| c_line.match(regexp) {|m| c_log[key] = m.to_a.last}}
      c_thread, c_body = c_log[:thread], c_log[:body]

      # ignore log if no log-body or thread-ID was found in c_line
      unless (c_body.to_s.strip.empty? or c_thread.nil?)
        # if a new thread is running it's c_body will be nil. Convert this nil to empty-String to be able to apply the Stringoperations below
        log[c_thread] = log[c_thread].to_s
        # if a new req is started before last finished (i.e. :stat was found), last request was incomplete
        # start over with current line as a new request
        if c_body.match?(BODY[:request])
          log[c_thread]=c_body
        # if :stat was found the current thread's log is complete
        # append the current body and scan log for keywords and add to matches
        elsif c_body.match?(BODY[:stat])
          log[c_thread].concat(c_body)
          BODY.each_pair {|key, regexp| log[c_thread].match(regexp) {|m| c_match[key] = m.to_a.last}}
          matches.push(c_match.clone)
          # reset current match for next iteration
          c_match.clear
          # delete current threads entries from log to improve runtime
          log.delete(c_thread)
        # if client req is routed to media-server, ignore log
        elsif c_body.match?(BODY[:dragon])
          log.delete(c_thread)
        # append current body of log to last body of current thread
        else
          log[c_thread].concat(c_body)
        end
      end

    end
    log.clear
    matches

  end

end
