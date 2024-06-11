require 'test_helper'

class SectionTest < ActiveSupport::TestCase
  test 'validates teacher can take a subject' do
    math = subjects(:math)
    english_teacher = teachers(:english_teacher)
    math_section = Section.create subject: math, teacher: english_teacher
    assert_equal math_section.errors[:teacher], ["Teacher can't teach a subject"]
  end

  test 'validates start time in the acceptable range' do
    section = sections(:everyday_math_section)
    section.start_time = "05:30 AM"
    section.save
    assert_equal section.errors[:start_time], ["should be between #{Section::EARLIEST_TIME_TO_START} and #{Section::LATEST_TIME_TO_START}"]
  end

  test 'overlaps? returns true' do
    section = sections(:three_days_math_section)
    math_teacher = teachers(:math_teacher)
    math = subjects(:math)
    other_section = Section.create subject: math, teacher: math_teacher, schedule_kind: "monday_wednesday_friday", start_time: "10:00 AM"

    assert_equal other_section.overlaps?(section), true
  end

  test 'overlaps? returns false' do
    section = sections(:three_days_math_section)
    math_teacher = teachers(:math_teacher)
    math = subjects(:math)
    other_section = Section.create subject: math, teacher: math_teacher, schedule_kind: "monday_wednesday_friday", start_time: "01:00 PM"

    assert_equal other_section.overlaps?(section), false
  end
end
