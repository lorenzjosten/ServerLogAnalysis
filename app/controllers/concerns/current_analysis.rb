module CurrentAnalysis

  private

  def current_analysis
    begin
      @analysis = Analysis.find(session[:analysis_id])
    rescue ActiveRecord::RecordNotFound
      Analysis.destroy_all
      @analysis = Analysis.create
      session[:analysis_id] = @analysis.id
    end
  end
end
