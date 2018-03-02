class AccessDatum < ApplicationRecord
  belongs_to :input_file

  def timeframe=(start_time_field, end_time_field)
    @timeframe = {start_t: start_time_field, end_t: end_time_field}
  end
end
