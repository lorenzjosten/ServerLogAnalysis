class AnalysesController < ApplicationController
  include AnalysisModule::CurrentAnalysis
  before_action :get_current_analysis, only: [:show]

  def show
    if @analysis.errors.any?
      respond_to do |format|
        format.js {render 'notifications/error/show', locals: {errors: @analysis.errors}}
        format.html {render 'analyses/error'}
      end
    end
    respond_to do |format|
      format.html
    end
  end

end
