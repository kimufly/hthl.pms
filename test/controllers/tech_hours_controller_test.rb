require 'test_helper'

class TechHoursControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tech_hour = tech_hours(:one)
  end

  test "should get index" do
    get tech_hours_url
    assert_response :success
  end

  test "should get new" do
    get new_tech_hour_url
    assert_response :success
  end

  test "should create tech_hour" do
    assert_difference('TechHour.count') do
      post tech_hours_url, params: { tech_hour: { describe: @tech_hour.describe, project_id: @tech_hour.project_id, start_at: @tech_hour.start_at, time_limit: @tech_hour.time_limit, user_id: @tech_hour.user_id } }
    end

    assert_redirected_to tech_hour_url(TechHour.last)
  end

  test "should show tech_hour" do
    get tech_hour_url(@tech_hour)
    assert_response :success
  end

  test "should get edit" do
    get edit_tech_hour_url(@tech_hour)
    assert_response :success
  end

  test "should update tech_hour" do
    patch tech_hour_url(@tech_hour), params: { tech_hour: { describe: @tech_hour.describe, project_id: @tech_hour.project_id, start_at: @tech_hour.start_at, time_limit: @tech_hour.time_limit, user_id: @tech_hour.user_id } }
    assert_redirected_to tech_hour_url(@tech_hour)
  end

  test "should destroy tech_hour" do
    assert_difference('TechHour.count', -1) do
      delete tech_hour_url(@tech_hour)
    end

    assert_redirected_to tech_hours_url
  end
end
