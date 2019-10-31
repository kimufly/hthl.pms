require 'test_helper'

class RolesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get roles_index_url
    assert_response :success
  end

end
