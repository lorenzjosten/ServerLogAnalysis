class AnalysisController < ApplicationController

  before_action :set_input_file, only: [:index]

  def index
  end

  def set_timeframe
    @timeframe = timeframe_params
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

  def timeframe_params
    params.require(:timeframe).permit(:start_time_field, :end_time_field)
  end
end
