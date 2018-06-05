class Scanner < ApplicationRecord
  include ScannerModule

  belongs_to :input_file
  validates_presence_of :input_file_id, on: :create
  validates_numericality_of :progress, greater_than_or_equal_to: 0, less_than_or_equal_to: 100

  after_initialize :create_enumerator, :create_log_buffer
  attr_reader :progress

  def next_match
    until match||=nil do
      begin
        line, l_num = @lines.next
        @log_buffer.update(line)
        match = @log_buffer.matches
        update(progress: 100*l_num.to_f/@lines.count)
      rescue StopIteration
        update(progress: 100)
        break
      end
    end
    match
  end

  private

  def create_log_buffer
    @log_buffer = ScannerModule::LogBuffer.new
  end

  def create_enumerator
    input_file = InputFile.find(self.input_file_id)
    @lines = input_file.data.lines.each_with_index
  end

end
