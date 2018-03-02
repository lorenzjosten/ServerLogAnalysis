class InputFile < ApplicationRecord
  input_file.instance_variable_set(:@route_key, 'input_file')

  has_many :access_data

  def uploaded_file=(file_field)
    self.name = File.basename(file_field.original_filename).gsub(/[^\w._-]/,'')
    self.content_type = file_field.content_type.chomp
    self.data = file_field.read
  end
end
