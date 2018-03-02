class AnalysisController < ApplicationController

  include CurrentInputFile

  before_action :current_input_file, only: [:index, :set_timeframe]

  def index
  end

  def set_timeframe
    @t_start = timeframe_params[:t_start]
    @t_end = timeframe_params[:t_end]
  end

  private

  def timeframe_params
    params.require(:timeframe).permit(:t_start, :t_end)
  end
end
