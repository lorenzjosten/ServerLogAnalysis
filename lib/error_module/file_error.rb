module ErrorModule
  class FileError < CustomError
    attr_reader :status, :error, :message

    def initialize(error = nil, status = nil, msg = nil)
      @error = error || 400
      @status = status || :file_error
      @message = msg || 'File could not be processed'
    end

  end
end
