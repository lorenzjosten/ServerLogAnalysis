module ErrorModule
  class NoFileError < FileError
    def initialize
      super(402, :file_error, "No file selected")
    end
  end
end
