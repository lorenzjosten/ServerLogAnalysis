class TimeframesController < ApplicationController
  include AnalysisModule::CurrentAnalysis
  before_action :get_current_analysis, only: [:create]
  before_action :get_timeframe, only: [:create]

  def create
    @timeframe = @analysis && @analysis.build_timeframe(timeframe_params)
    unless @timeframe.save
      raise ErrorModule::DateError
    end
    respond_to do |format|
      format.js
    end
  end

  private

  def get_timeframe
    params[:timeframe].present? || (raise ErrorModule::NoDateError)
  end

  def timeframe_params
    params.require(:timeframe).permit(:start_dt => {}, :end_dt => {})
  end
end
