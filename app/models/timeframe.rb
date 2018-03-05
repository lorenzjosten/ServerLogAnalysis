class Timeframe < ApplicationRecord

  def timeframe=(t_start, t_end)
    self.t_start = t_start
    self.t_end = t_end
  end

end
