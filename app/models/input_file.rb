class InputFile < ApplicationRecord
  belongs_to :analysis

  validates_format_of :content_type, with: /\Atext/, message: "Please select a text-file"
  validates_size_of :data, allow_blank: false, message: "The file you selected is empty"
  validates_size_of :data, maximum: 20.megabytes, message: "The file you selected is too big"
  validates_presence_of :name, allow_blank: false

  def uploaded_file=(file_field)
    self.name = get_name(file_field.original_filename)
    self.content_type = file_field.content_type.chomp
    self.data = file_field.read
  end

  private

  def get_name(file_name)
    File.basename(file_name).gsub(/[^\w._-]/, '')
  end

end
