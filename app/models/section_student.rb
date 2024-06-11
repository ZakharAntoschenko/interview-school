class SectionStudent < ApplicationRecord
  belongs_to :student
  belongs_to :section

  validates :student, uniqueness: { scope: :section }

  validate :other_sections_overlap

  def other_sections_overlap
    student.sections.map do |student_section|
      if student_section.overlaps?(section)
        errors.add(:section, "sections cant overlap for the same student.")
        return false
      end
    end
    true
  end
end
