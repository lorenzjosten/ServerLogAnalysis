module AnalysisModule
  module CurrentAnalysis
    def get_current_analysis
      begin
        @analysis ||= Analysis.find_by(id: session[:analysis_id])
      rescue ActiveRecord::RecordNotFound => e
        @analysis = Anaylsis.create
        session[:analysis_id] = @analysis.id
        render @analysis
      end
    end
  end
end
