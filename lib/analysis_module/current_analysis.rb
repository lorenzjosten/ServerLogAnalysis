module AnalysisModule
  module CurrentAnalysis
    def get_current_analysis
      begin
        @analysis ||= Analysis.find(session[:analysis_id])
      rescue ActiveRecord::RecordNotFound
        @analysis = Analysis.create
        session[:analysis_id] = @analysis.id
      end
    end
  end
end
