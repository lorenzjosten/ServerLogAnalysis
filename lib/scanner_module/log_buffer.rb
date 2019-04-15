module ScannerModule
  class LogBuffer
    def initialize
      @buffer = []
    end
    def add(line="")
      logline = LogLine.new(line)
      thread_id = logline.thread_id
      log = get_log(thread_id) || add_log(thread_id)
      log.append(logline)
    end
    def get_match
      if (log = @buffer.find {|log| log.complete?})
        matches = @buffer.delete(log).matches
        matches if log.valid?
      end
    end
    def get_log(thread_id="")
      @buffer.find {|log| log.thread_id == thread_id}
    end
    def add_log(thread_id="")
      @buffer.push(Log.new(thread_id)).last
    end
  end
end
