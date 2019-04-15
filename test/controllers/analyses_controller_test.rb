require 'test_helper'

class AnalysesControllerTest < ActionDispatch::IntegrationTest
  test "should get analysis view" do
    get analysis_url(analyses(:valid))
    assert_response :success
  end
end
