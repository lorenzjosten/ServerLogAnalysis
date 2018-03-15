class InputFilesController < ApplicationController

  include CurrentAnalysis
  include LogFileScanner

  before_action :current_analysis, only: [:update]

  def create
    @input_file = @analysis.build_input_file(input_file_params)
    access_data = scan(@input_file.data)
    @input_file.access_data.create(access_data)
    redirect_to '/' if @input_file.save
  end

  def update
    @input_file = @analysis.input_file
    if @input_file.update(input_file_params)
      access_data = scan(@input_file.data)
      @input_file.access_data.create(access_data) if @input_file.access_data.destroy_all
      redirect_to '/'
    end
  end

  private

  def input_file_params
    params.require(:file_field).permit(:uploaded_file)
  end

end
