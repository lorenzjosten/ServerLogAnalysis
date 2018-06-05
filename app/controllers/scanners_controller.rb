class ScannersController < ApplicationController
  include AnalysisModule::CurrentAnalysis
  before_action :get_current_analysis, only: [:show]
  before_action :current_input_file, only: [:show]

  def show
    @scanner = @input_file.scanner
    @progress = @scanner.read_attribute(:progress)
    respond_to do |format|
      format.js
    end
  end

  private

  def current_input_file
    begin
      @input_file = InputFile.find(params[:input_file_id])
    rescue ActiveRecord::RecordNotFound => e
      render @analysis
    end
  end

end
