module CurrentInputFile

  private

  def new_input_file
    InputFile.destroy_all
    @input_file = InputFile.create
    session[:input_file_id] = @input_file.id
  end

  def current_input_file
    return unless session[:input_file_id]
    begin
      @input_file = InputFile.find(session[:input_file_id])
    rescue ActiveRecord::RecordNotFound
      @input_file = nil
    end
  end
end
