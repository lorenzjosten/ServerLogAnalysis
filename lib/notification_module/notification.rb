module NotificationModule
  class Notification
    def initialize(code = nil, status = nil, msg = nil)
      @code = code || 999
      @status = status || :notification
      @message = msg || 'Something went wrong'
    end
    def sanitize
      @status.to_s+" "+@error.to_s+": "+@message
    end
  end
end
