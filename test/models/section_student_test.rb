require 'test_helper'

class SectionStudentTest < ActiveSupport::TestCase

  test 'overlaps? returns true' do
    section_student = section_students(:everyday_math_session_jack)
    section = sections(:two_days_math_section)
    section.update_column(:start_time, "10:00 AM")

    overlap_section_student = SectionStudent.create student: section_student.student, section: section
    assert_equal overlap_section_student.errors[:section], ["sections cant overlap for the same student."]
  end
end
