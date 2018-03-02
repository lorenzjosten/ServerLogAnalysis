class AnalysisController < ApplicationController

  before_action :set_input_file, only: [:index]

  def index
    byebug
  end

  private

  def set_input_file
    begin
      @input_file = InputFile.find(params[:input_file][:id])
    rescue
      @input_file = InputFile.new
      @input_file.access_data.build
    end
  end
end
