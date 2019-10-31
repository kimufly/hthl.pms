require 'test_helper'

class CostsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get costs_index_url
    assert_response :success
  end

end
