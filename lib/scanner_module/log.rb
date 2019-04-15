module ScannerModule
  class Log

    include ScannerConstants

    attr_reader :thread_id, :matches

    def initialize(thread_id="")
      @thread_id = thread_id
      @msg = ""
      @matches = {}
    end

    def append(logline)
      (@msg.concat(logline.body) && match!) if logline.valid? && logline.thread_id == @thread_id
    end

    def complete?
      @matches.keys.include?(:dragon) || @matches.keys.include?(:respT)
    end

    def match!
      MATCH.each_pair do |key, reg|
        match = @msg.match(reg).to_a.last
        @matches.merge!({key => match}) if match
      end
    end

    def valid?
      !empty? && filter_stat && filter_urls && filter_request && filter_media
    end

    def empty?
      @thread_id.empty? || @msg.empty?
    end

    def filter_stat
      @matches.keys.include?(:stat) ? STAT_FILTER.inject(false) {|bool, reg| bool || @matches[:stat].match?(reg)} : true
    end

    def filter_urls
      @matches.keys.include?(:url) ? URL_FILTER.inject(true) {|bool, reg| bool && !@matches[:url].match?(reg)} : true
    end

    def filter_request
      @matches.keys.include?(:request) ? REQUEST_FILTER.inject(false) {|bool, reg| bool || @matches[:request].match?(reg)} : true
    end

    def filter_media
      !@matches.keys.include?(:dragon)
    end

  end
end
