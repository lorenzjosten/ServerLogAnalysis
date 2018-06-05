module ErrorModule
  class DataError < CustomError
    attr_reader :status, :error, :message

    def initialize(error = nil, status = nil, msg = nil)
      @error = error || 500
      @status = status || :data_error
      @message = msg || 'Data could not be processed'
    end
  end
end
