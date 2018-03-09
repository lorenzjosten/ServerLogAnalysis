module CurrentInputFile

  private

  def new_input_file
    InputFile.destroy_all
    @input_file = InputFile.create
    session[:input_file_id] = @input_file.id
  end

  def current_input_file
    begin
      @input_file = InputFile.find(session[:input_file_id])
    rescue ActiveRecord::RecordNotFound
      new_input_file
    end
  end
end
