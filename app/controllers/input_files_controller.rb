class InputFilesController < ApplicationController
  include AnalysisModule::CurrentAnalysis
  before_action :get_current_analysis, only: [:create]

  def create
    @input_file = @analysis.build_input_file(file_params)
    @input_file.create_scanner
    if @input_file.save
      CreateAccessDataJob.perform_later(@input_file)
    end
    respond_to do |format|
      format.js {render partial: 'errors/show', locals: {errors: @input_file.errors} if @input_file.errors.any?}
    end
  end

  private

  def file_params
    params.require(:input_file).permit(:uploaded_file)
  end
end
