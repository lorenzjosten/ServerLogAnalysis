class AnalysisController < ApplicationController

  include CurrentInputFile
  include CurrentTimeframe

  before_action :current_input_file, only: [:index]
  before_action :current_timeframe, only: [:index]
  before_action :timeframe_select_options, only: [:index]

  def index
    p = PlotData.new(@input_file.access_data, @timeframe)
    @site_visits = p.site_visits
    @url_visits = p.url_visits
    @server_response = p.server_response
  end

  private

  def timeframe_select_options
    @datetime_select_options = {
      order: [:day, :month, :year, :hour, :minute],
      use_two_digit_numbers: true,
      minute_step: 10,
    }
    if @input_file.access_data.any?
      @datetime_select_options.merge!({
        start_year: @input_file.access_data.first.access_time.year,
        end_year: @input_file.access_data.last.access_time.year,
      })
      @datetime_start_options = @datetime_select_options.merge({selected: @input_file.access_data.first.access_time})
      @datetime_end_options = @datetime_select_options.merge({selected: @input_file.access_data.last.access_time})
      @datetime_submit_options = {disabled: false}
    else
      @datetime_select_options.merge!({disabled: true})
      @datetime_start_options = @datetime_select_options.clone
      @datetime_end_options = @datetime_select_options.clone
      @datetime_submit_options = {disabled: true}
    end
  end

end
