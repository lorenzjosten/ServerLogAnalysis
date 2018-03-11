class AnalysisController < ApplicationController

  include CurrentInputFile
  include CurrentTimeframe

  before_action :current_input_file, only: [:index]
  before_action :current_timeframe, only: [:index]
  before_action :timeframe_select_defaults, only: [:index]

  def index
    @plot_data = PlotData.new(@input_file.access_data, @timeframe)
  end

  private

  def timeframe_select_defaults
    @start_date = @timeframe.start_date.strftime("%Y:%m:%d")
    @start_time = @timeframe.start_time.strftime("%H:%M")
    @end_date = @timeframe.end_date.strftime("%Y:%m:%d")
    @end_time = @timeframe.end_time.strftime("%H:%M")
  end
end
