require 'test_helper'

class AnalysisTest < ActiveSupport::TestCase
  test "analyses can be created without parameters" do
    assert Analysis.create, "Analysis can't be created without parameters"
  end

  test "analysis has an input_file" do
    analysis = analyses(:valid)
    assert analysis.respond_to?(:input_file), "Analysis does not have an input_file"
  end

  test "analysis has more than one input_file" do
    analysis = analyses(:valid)
    assert_not analysis.respond_to?(:input_files), "Analysis should not have a collection of input_files"
  end

  test "analysis ensures valid input_file" do
    analysis = analyses(:valid)
    analysis.build_input_file
    refute analysis.valid?
    assert_not_nil analysis.errors[:input_file], "Analysis needs a valid input_file"
  end
end
