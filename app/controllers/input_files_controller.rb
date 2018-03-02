class InputFilesController < ApplicationController
  before_action :destroy_old_file, only: [:create]

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

  def destroy_old_file
    InputFile.destroy_all
  end
end
