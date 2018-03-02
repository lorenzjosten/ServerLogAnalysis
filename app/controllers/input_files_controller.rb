class InputFilesController < ApplicationController

  include LogFileScanner
  include CurrentInputFile

  before_action :new_input_file, only: [:create]

  def create
    @input_file.update(input_file_params)
    access_data = scan(@input_file.data)
    @input_file.access_data.build(access_data)
    redirect_to '/' if @input_file.save
  end

  private

  def input_file_params
    params.require(:input_file).permit(:uploaded_file)
  end

end
