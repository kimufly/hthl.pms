require 'test_helper'

class ApprovesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get approves_index_url
    assert_response :success
  end

end
