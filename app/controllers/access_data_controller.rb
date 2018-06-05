class AccessDataController < ApplicationController
  include NotificationModule::NotificationHandler
  include AnalysisModule::CurrentAnalysis

  before_action :get_current_analysis, only: [:index]
  before_action :get_current_file, only: [:index]
  before_action :get_current_timeframe, only: [:index]

  def index
    @access_data = @input_file.access_data
    @start_dt = @timeframe.read_attribute(:start)
    @end_dt = @timeframe.read_attribute(:end)
    respond_to do |format|
      format.js {
        notify(NotificationModule::NoAccessDataWarning) unless @access_data.any?
        notify(NotificationModule::NoPlotDataWarning) unless @access_data.plot_data.any?
        render 'notifications/error/show', locals: {:errors => @access_data.errors} if @access_data.errors.any?
        render 'notifications/warning/show', locals: {:notifications => @notifications} if @notifications.any?
      }
    end
  end

  private

  def get_current_file
    @input_file = @analysis.input_file ||= @analysis.build_input_file
  end

  def get_current_timeframe
    @timeframe = @analysis.timeframe ||= @analysis.build_timeframe
  end
end
