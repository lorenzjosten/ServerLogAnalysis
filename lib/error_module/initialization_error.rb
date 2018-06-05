module ErrorModule
  class InitializationError < CustomError
    attr_reader :status, :error, :message

    def initialize(error = nil, status = nil, msg = nil)
      @error = error || 404
      @status = status || :intialization_error
      @message = msg || 'Session could not be initialized'
    end

  end
end
