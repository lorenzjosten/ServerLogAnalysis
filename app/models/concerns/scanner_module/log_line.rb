module ScannerModule
  class LogLine
    include ScannerConstants
    attr_reader :thread_id, :body
    def initialize(line="")
      @thread_id = line.match(LOGLINE[:thread]).to_a.last.to_s.strip
      @body = line.match(LOGLINE[:body]).to_a.last.to_s
    end
    def valid?
      (@thread_id.empty? || @body.strip.empty?) ? false : true
    end
  end
end
