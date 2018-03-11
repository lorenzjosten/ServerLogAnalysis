class InputFile < ApplicationRecord
  model_name.instance_variable_set(:@route_key, 'input_file')

  has_many :access_data, dependent: :destroy

  def uploaded_file=(uploaded_file)
    self.name = File.basename(uploaded_file.original_filename).gsub(/[^\w._-]/,'')
    self.content_type = uploaded_file.content_type.chomp
    self.data = uploaded_file.tempfile.read
  end

end
