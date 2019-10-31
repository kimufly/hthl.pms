require 'test_helper'

class UserPasswordControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get user_password_index_url
    assert_response :success
  end

end
