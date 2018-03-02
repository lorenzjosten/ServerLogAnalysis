class AccessDataController < ApplicationController
  def set_timeframe
    timeframe(timeframe_params)
  end

  private

  def timeframe_params
    params.require(:timeframe).permit(:timeframe)
  end
end
