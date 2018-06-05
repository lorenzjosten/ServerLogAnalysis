module ScannerModule
  class LogBuffer
    def initialize
      @buffer = []
    end
    def update(line="")
      logline = LogLine.new(line)
      thread_id = logline.thread_id
      log = (self.get(thread_id) || @buffer.push(ThreadLog.new(thread_id)).last)
      log.append(logline) && log.match!
      @buffer.keep_if {|log| log.valid?}
    end
    def matches
      (log = @buffer.find {|log| log.complete?}) && @buffer.delete(log).matches
    end
    def get(thread_id="")
      @buffer.find {|log| log.thread_id == thread_id}
    end
  end
end
