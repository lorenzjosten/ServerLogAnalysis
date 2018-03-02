class AnalysisController < ApplicationController

  include CurrentInputFile

  before_action :current_input_file, only: [:index, :set_timeframe]

  def index
  end

  def set_timeframe
    @t_start = parse_datetime(timeframe_params.permit(:t_start))
    @t_end = parse_datetime(timeframe_params.permit(:t_end))
    byebug
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
end
