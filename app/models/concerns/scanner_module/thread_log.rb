module ScannerModule
  class ThreadLog
    include ScannerConstants
    attr_reader :thread_id, :msg, :matches
    def initialize(thread_id="")
      @thread_id = thread_id
      @msg = ""
      @matches = {}
    end
    def append(logline)
      if logline.valid? && logline.thread_id == self.thread_id
        self.msg.concat(logline.body)
      end
    end
    def valid?
      (self.empty? || self.matches.keys.include?(:dragon)) ? false : true
    end
    def complete?
      self.matches.keys.include?(:stat) ? true : false
    end
    def match!
      MATCH.each_pair do |key, regexp|
        match = self.msg.match(regexp).to_a.last
        self.matches.merge!({key => match}).keep_if {|key, val| val}
      end
    end
    def empty?
      self.thread_id.empty? || self.msg.empty?
    end
  end
end
