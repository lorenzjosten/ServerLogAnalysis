class CreateAccessDataJob < ApplicationJob
  queue_as :default

  def perform(input_file)
    scanner = input_file.scanner
    while scanner.read_attribute(:progress) < 100
      input_file.access_data.create(scanner.next_match) || (raise ErrorModule::DataError)
    end
  end
end
