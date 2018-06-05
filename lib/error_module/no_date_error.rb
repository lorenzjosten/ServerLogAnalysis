module ErrorModule
  class NoDateError < DateError
    def initialize
      super(601, :date_error, "Please select start and end date")
    end
  end
end
