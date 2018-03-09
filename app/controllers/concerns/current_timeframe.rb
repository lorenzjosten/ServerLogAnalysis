module CurrentTimeframe

  private

  def current_timeframe
    begin
      @timeframe = Timeframe.find(session[:timeframe_id])
    rescue ActiveRecord::RecordNotFound
      Timeframe.destroy_all
      @timeframe = Timeframe.create
      session[:timeframe_id] = @timeframe.id
    end
  end

end
