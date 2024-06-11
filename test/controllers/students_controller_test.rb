require 'test_helper'

class StudentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @student = students(:jack)
  end

  test "should get index" do
    get students_url
    assert_response :success
  end
end
