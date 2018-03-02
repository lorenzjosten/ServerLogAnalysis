class InputFilesController < ApplicationController
  def create
    @input_file = InputFile.new(input_file_params)
    if @input_file.save
      redirect_to '/'
    end
  end

  private

  def input_file_params
    params.require(:input_file).permit(:uploaded_file)
  end
end
