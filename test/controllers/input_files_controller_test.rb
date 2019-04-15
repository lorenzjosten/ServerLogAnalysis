require 'test_helper'

class InputFilesControllerTest < ActionDispatch::IntegrationTest
   test "should send post request" do
     post input_files_url, xhr: true
     assert_response :success
   end

   test "create should override analysis input_file" do
     analysis = analyses(:valid)
     analysis.create_input_file( name: "some_file", data: "some_data", content_type: "text" )
     assert_difference('InputFile.count', 0) do
      post input_files_url, xhr: true
     end
     assert_response :success
   end
end
