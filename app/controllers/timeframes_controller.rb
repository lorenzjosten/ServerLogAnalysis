class TimeframesController < ApplicationController

  include CurrentTimeframe

  before_action :set_timeframe, only: [:create, :update]

  def create
    @timeframe.update(timeframe_params)
  end

  def update
    @timeframe.update(timeframe_params)
  end

  private

  def timeframe_params
    params.require(:timeframe).permit(:t_start, :t_end)
  end

end
