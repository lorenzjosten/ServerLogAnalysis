class AnalysisController < ApplicationController

  include CurrentInputFile

  before_action :current_input_file, only: [:index]
  before_action :datetime_select_options, only: [:index]

  def index
  end

  def set_timeframe
    @t_start = parse_datetime(timeframe_params.permit(:t_start))
    @t_end = parse_datetime(timeframe_params.permit(:t_end))
  end

  private

  def timeframe_params
    params.require(:timeframe).permit(:t_start, :t_end)
  end

  def parse_datetime(dt_hash)
    format_values = Proc.new {|arr| arr.each_with_index{|val,i| arr[i]=val.rjust(2,'0')}}
    datetime = Proc.new {|arr| DateTime.parse(arr[2]+arr[1]+arr[0]+'T'+arr[3]+arr[4])}

    tmp = format_values.call(dt_hash.values)
    datetime.call(tmp)
  end

  def datetime_select_options
    if @input_file.access_data.any?
      t_start = @input_file.access_data.first.access_time
      t_end = @input_file.access_data.last.access_time
      @datetime_start_options = {
        order: [:day, :month, :year, :hour, :minute],
        use_two_digit_numbers: true,
        start_year: t_start.year,
        end_year: t_end.year,
        start_month: t_end.year > t_start.year ? t_start.month,
        start_day: t_start.day,
        start_hour: t_start.hour,
        start_minute: t_start.min,
      }
      @datetime_end_options = {
        order: [:day, :month, :year, :hour, :minute],
        use_two_digit_numbers: true,
        end_year: t_end.year,
        end_month: t_end.month,
        end_day: t_end.day,
        end_hour: t_end.hour,
        end_minute: t_end.min,
      }
      @datetime_submit_option = {disabled: false}
    else
      @datetime_start_options = {disabled: true}
      @datetime_end_options = {disabled: true}
      @datetime_submit_option = {disabled: true}
    end
    byebug
  end
end
