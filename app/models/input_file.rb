class InputFile < ApplicationRecord
  has_one :scanner, dependent: :destroy
  has_many :access_data, dependent: :destroy
  belongs_to :analysis

  validates_presence_of(:data, :name, :content_type)
  validates_format_of :content_type, with: /\Atext/, message: "Please select a text-file"
  validates_associated :scanner, :access_data
  validate :data_readable

  def uploaded_file=(file_field)
    self.name = get_name(file_field.original_filename)
    self.content_type = file_field.content_type.chomp
    self.data = file_field.read
  end

  private

  def data_readable
    errors.add(:data, "File data not readable") unless data.respond_to?(:read)
  end

  def get_name(file_name)
    File.basename(file_name).gsub(/[^\w._-]/, '')
  end
end
