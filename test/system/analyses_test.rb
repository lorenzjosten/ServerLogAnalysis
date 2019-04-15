require "application_system_test_case"

class AnalysesTest < ApplicationSystemTestCase
  test "visiting a valid analysis" do
    visit analysis_url(analyses(:valid))
    assert_selector "div"
  end
end
