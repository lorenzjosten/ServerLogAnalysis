class InputFilesController < ApplicationController
  include AnalysisModule::CurrentAnalysis
  before_action :get_current_analysis, only: [:create]
  before_action :cancel_file_scan, only: [:create]

  def create
    @input_file = @analysis.build_input_file(file_params)
    if @input_file.save
      session[:worker_id] = FileScanWorker.perform_async(@input_file.id)
      respond_to do |format|
        format.js { render @input_file }
      end
    else
      @errors = @input_file.errors
      respond_to do |format|
        format.js { render partial: 'notifications/notifications', locals: {messages: @errors.full_messages} }
      end
    end
  end

  private

  def file_params
    params.fetch(:input_file, {}).permit(:uploaded_file)
  end

  def cancel_file_scan
    FileScanWorker.cancel!(session[:worker_id])
    begin sleep 0.2 end while FileScanWorker.working?(session[:worker_id])
  end
end
