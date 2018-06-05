module InputFileModule
  module CurrentInputFile
    include CurrentAnalysisModule
    def get_current_input_file
      get_current_analysis
      @input_file = @analysis.input_file
    end
  end
end
