class AnalysesController < ApplicationController

  include CurrentAnalysis

  before_action :current_analysis, only: [:index]

  def index
    @plot_data = PlotData.new(@analysis.input_file.access_data, @analysis.timeframe)
  end

end
