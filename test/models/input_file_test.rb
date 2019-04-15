require 'test_helper'

class InputFileTest < ActiveSupport::TestCase

  test "file should not be empty" do
    input_file = input_files(:empty_text_file)
    input_file.data = Random.new.bytes( 0 )
    refute input_file.valid?
    assert_not_nil input_file.errors[:data], "File should not be empty"
  end

  test "file size should not be greater than 20 mb" do
    input_file = input_files(:empty_text_file)
    input_file.data = Random.new.bytes( 21*2**20 )
    refute input_file.valid?
    assert_not_nil input_file.errors[:data], "File size should not be greater than 20mb"
  end

  test "file should be named" do
    input_file = input_files(:text_file_without_name)
    refute input_file.valid?
    assert_not_nil input_file.errors[:name], "File should be named"
  end

  test "file should be a text file" do
    input_file = input_files(:not_a_text_file)
    refute input_file.valid?
    assert_not_nil input_file.errors[:content_type], "File should be a text-file"
  end
end
