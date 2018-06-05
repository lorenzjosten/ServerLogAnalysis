module ErrorModule
  class DateError < CustomError
    attr_reader :status, :error, :message

    def initialize(error = nil, status = nil, msg = nil)
      @error = error || 600
      @status = status || :date_error
      @message = msg || 'Date selection failed'
    end

  end
end
