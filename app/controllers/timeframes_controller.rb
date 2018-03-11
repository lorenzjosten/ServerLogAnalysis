class TimeframesController < ApplicationController

  include CurrentTimeframe

  before_action :current_timeframe, only: [:update]

  def update
    @timeframe.update(timeframe_params)
    redirect_to '/'
  end

  private

  def timeframe_params
    params.require(:timeframe).permit(:start_date, :start_time, :end_date, :end_time)
  end

end
