module ErrorModule
  class CustomError < StandardError
    def initialize(error = nil, status = nil, msg = nil)
      @error = error || 999
      @status = status || :custom_error
      @message = msg || 'Something went wrong'
    end
    def sanitize
      @status.to_s+" "+@error.to_s+": "+@message
    end
  end
end
