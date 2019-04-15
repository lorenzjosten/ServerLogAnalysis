class AnalysesController < ApplicationController
  include AnalysisModule::CurrentAnalysis
  before_action :get_current_analysis, only: [:show]

  def show
    respond_to do |format|
      format.html
    end
  end

end
