class TimeframesController < ApplicationController

  include CurrentAnalysis

  before_action :current_analysis, only: [:update]

  def create
    @timeframe = @analysis.build_timeframe(timeframe_params)
    redirect_to '/' if @timeframe.save
  end

  def update
    redirect_to '/' if @analysis.timeframe.update(timeframe_params)
  end

  private

  def timeframe_params
    params.require(:timeframe).permit(:start_date, :start_time, :end_date, :end_time)
  end

end
