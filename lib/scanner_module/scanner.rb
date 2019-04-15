module ScannerModule
  class Scanner

    def next_match
      find_match.first
    end

    def progress
      (@data.size==0) ? 100 : (0.5+100*@bytes_read/@data.size).to_i
    end

    private

    def initialize(data="")
      @data = StringIO.new( data )
      @bytes_read = 0.0
      @buffer = ScannerModule::LogBuffer.new
    end

    def find_match
      Enumerator.new do |y|
        @data.each_line do |line|
          @bytes_read += line.size
          @buffer.add(line)
          match = @buffer.get_match
          y.yield match if match
        end
      end
    end

  end
end
