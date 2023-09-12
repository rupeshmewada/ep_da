require "test_helper"

class SpecializationsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get specializations_index_url
    assert_response :success
  end
end
