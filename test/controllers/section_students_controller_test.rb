require 'test_helper'

class SectionStudentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @section_student = section_students(:everyday_math_session_jack)
    @student = @section_student.student
    @english_section = sections(:everyday_english_section)
  end

  test "should get new" do
    get new_student_section_student_url(@student)
    assert_response :success
  end

  test "should create section_student" do
    assert_difference('SectionStudent.count') do
      post student_section_students_url(@student), params: { section_student: { section_id: @english_section.id } }
    end

    assert_redirected_to student_section_students_url(@section_student.student_id)
  end

  test "should not create overlapping section" do
    overlapping_section = sections(:everyday_math_section)
    overlapping_section.update_column(:start_time, "10:00 AM")

    assert_no_difference('SectionStudent.count') do
      post student_section_students_url(@student), params: { section_student: { section_id: overlapping_section.id } }
    end
  end

  test "should destroy section_student" do
    assert_difference('SectionStudent.count', -1) do
      delete section_student_url(@section_student)
    end

    assert_redirected_to student_section_students_url(@section_student.student_id)
  end
end
