require "test_helper"

class EnrollmentsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get enrollments_show_url
    assert_response :success
  end

  test "should get create" do
    get enrollments_create_url
    assert_response :success
  end
end
