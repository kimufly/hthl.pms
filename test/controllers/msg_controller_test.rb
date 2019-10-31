require 'test_helper'

class MsgControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get msg_index_url
    assert_response :success
  end

end
